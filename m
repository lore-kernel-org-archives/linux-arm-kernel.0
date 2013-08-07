From: stigge@antcom.de (Roland Stigge)
Date: Wed, 07 Aug 2013 14:46:03 +0200
Subject: MAX7301 GPIO: Do not force SPI speed when using OF Platform
In-Reply-To: <52023EF9.3050301@c-s.fr>
References: <51EFAA19.4020905@antcom.de> <52022FFF.3060507@c-s.fr>
 <52023AE2.3020007@antcom.de> <52023EF9.3050301@c-s.fr>
Message-ID: <5202418B.5090203@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/07/2013 02:35 PM, leroy christophe wrote:
>>> spi-bits = <16>;
>> I tried this, both in the device's and in the controller's node. But it
>> didn't work. However, as described, I didn't expect it to work, because
>> there is no code present to handle "spi-bits". At least not in 3.10.
>>
>> Am I missing something? Otherwise, maybe something of the tree that you
>> are talking about is missing from mainline still?
>>
>>
> Strange. I'm using 3.8.13
> I have it handled in drivers/spi/spi.c in function
> of_register_spi_devices()

3.8.13's (as well as newer ones') drivers/spi/spi.c doesn't handle
"spi-bits", see also

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/spi/spi.c?h=linux-3.8.y

Maybe you have additional patches that are not in mainline, yet?

Thanks,

Roland
