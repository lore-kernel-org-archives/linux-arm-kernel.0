From: stigge@antcom.de (Roland Stigge)
Date: Wed, 07 Aug 2013 14:17:38 +0200
Subject: MAX7301 GPIO: Do not force SPI speed when using OF Platform
In-Reply-To: <52022FFF.3060507@c-s.fr>
References: <51EFAA19.4020905@antcom.de> <52022FFF.3060507@c-s.fr>
Message-ID: <52023AE2.3020007@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/07/2013 01:31 PM, leroy christophe wrote:
> Le 24/07/2013 12:19, Roland Stigge a ?crit :
>> commit 047b93a35961f7a6561e6f5dcb040738f822b892 introduced the following
>> to gpio-max7301.c:
>>
>>     /* bits_per_word cannot be configured in platform data */
>> -    spi->bits_per_word = 16;
>> +    if (spi->dev.platform_data)
>> +        spi->bits_per_word = 16;
>>       ret = spi_setup(spi);
>>
>> Comment is: "The bit_per_word can be set in the OF Device tree, so no
>> need to force it as with the platform_data when using OF Platform"
>>
>> Can you please point me to the respective OF option? I couldn't find it
>> under drivers/spi/spi* or Documentation/devicetree/bindings/spi/*.
> 
> You have to add the following in your dts:
> 
> spi-bits = <16>;

I tried this, both in the device's and in the controller's node. But it
didn't work. However, as described, I didn't expect it to work, because
there is no code present to handle "spi-bits". At least not in 3.10.

Am I missing something? Otherwise, maybe something of the tree that you
are talking about is missing from mainline still?

Thanks in advance,

Roland
