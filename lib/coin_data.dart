import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '56E2473C-39E7-46F6-9B69-294D80BC18AA';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      //String url = '$coinAPIURL/BTC/USD?apikey=$apiKey';

      String url = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        var decoded = jsonDecode(res.body);

        dynamic lastprice = decoded['rate'];

        cryptoPrices[crypto] = lastprice.toStringAsFixed(0);
      } else {
        print(res.statusCode);
      }
    }
    return cryptoPrices;
  }
}
