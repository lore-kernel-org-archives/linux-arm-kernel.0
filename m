From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 7 Jun 2017 10:10:54 +0900
Subject: [PATCH v5 12/20] ARM: dts: uniphier: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <CABxcv=mPzDVTh_ZH1VtuHMUhVrR+hxz8GwcQT38hwJJqHY+fJA@mail.gmail.com>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-13-javier@dowhile0.org>
 <CAK7LNATDvesYLKimY=aKfT6kAiidq6Ufd=kCWGQcCZ_Xy-27tw@mail.gmail.com>
 <CABxcv=mPzDVTh_ZH1VtuHMUhVrR+hxz8GwcQT38hwJJqHY+fJA@mail.gmail.com>
Message-ID: <CAK7LNASBztX033t36vz_MXAgeyHd76roMBtRZ4mi-q9VFB4Lkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,


2017-06-06 18:04 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> Hello Masahiro,
>
> On Mon, Jun 5, 2017 at 7:13 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi.
>>
>> 2017-05-23 22:34 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
>>> The at24 driver allows to register I2C EEPROM chips using different vendor
>>> and devices, but the I2C subsystem does not take the vendor into account
>>> when matching using the I2C table since it only has device entries.
>>>
>>> But when matching using an OF table, both the vendor and device has to be
>>> taken into account so the driver defines only a set of compatible strings
>>> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>>>
>>> So add this generic fallback to the device node compatible string to make
>>> the device to match the driver using the OF device ID table.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>>>
>>> ---
>>>
>>> Changes in v5:
>>> - Only replace atmel variant but keep other EEPROM vendors (Geert Uytterhoeven).
>>>
>>> Changes in v4:
>>> - Only use the atmel manufacturer in the compatible string instead of
>>>   keeping the deprecated ones (Rob Herring).
>>>
>>> Changes in v3: None
>>> Changes in v2: None
>>>
>>>  arch/arm/boot/dts/uniphier-pro4-ace.dts    | 2 +-
>>>  arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 2 +-
>>>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>>
>> Why didn't you touch
>> arch/arm/boot/dts/uniphier-ref-daughter.dtsi ?
>>
>
> Because the compatible string "microchip,24lc128" used by the I2C
> EEPROM node on that DTS is not supported by the
> drivers/misc/eeprom/at24.c driver (in fact the only occurrence for
> 24lc128 I see is in that DTS).
>
> Maybe is a typo and it should be "microchip,24c128" instead ?

I do not think so.
I consulted a board developer.

I also see 24LC128 on Microchip web site:
http://www.microchip.com/wwwproducts/en/24LC128



-- 
Best Regards
Masahiro Yamada
