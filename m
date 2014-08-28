From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Fri, 29 Aug 2014 03:36:36 +0800
Subject: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
In-Reply-To: <4488604.oBeB6it8Vr@wuerfel>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>
 <20140828143733.GA18084@developer> <3440260.edal29kzlR@diego>
 <4488604.oBeB6it8Vr@wuerfel>
Message-ID: <53FF84C4.9080902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd & Heiko & Eduardo,

OK. Maybe you are right.

This driver should be put into drivers/iio/adc/* ,
Anyway,I will re-edit it ASAP.


? 2014/8/29 0:16, Arnd Bergmann ??:
> On Thursday 28 August 2014 18:11:43 Heiko St?bner wrote:
>> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
>>>> On the driver side, I believe the correct way to deal with this setup
>>>> is to split your driver into a generic drivers/iio/adc/rockchips-tsadc.c
>>>> file, and a smaller thermal driver that uses the iio in-kernel interfaces,
>>>> ideally one that is independent of the underlying hardware and can
>>>> work on any ADC implementation.
>>> Agreed. If you can write such interface and make your driver to work in
>>> such way, that would be great.
>> But I currently don't see how you would model the temperature handling parts
>> from a generic thermal driver to a generic adc driver for the rk3288-tsadc.
>>
>> I guess the general temperature irq handling would use iio-triggers? But how
>> does the target temperature get into the TSADC_COMP1_INT register.
>>
>> Also when getting the temperature, Caesar's driver compares it to its trip
>> points and sets the next trip point depending on the current temperature
>> (passive <-> critical) in rockchip_get_temp.
>>
>> Maybe there is some completely easy way for this, but currently I don't see
>> it.
> Eduardo earlier today replied to an email about a generic driver for
> thermal, which was posted in February but hasn't been merged.
> See https://lkml.org/lkml/2014/2/5/810
>
> There may be a newer version of this patch, which I haven't found.
>
> 	Arnd
>
>
>

-- 
Best regards,
Caesar
