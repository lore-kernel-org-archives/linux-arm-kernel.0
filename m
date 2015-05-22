From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 22 May 2015 15:09:30 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<2282066.NWoIT9ZyLc@wuerfel>	<CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>	<13641152.Yt4ZI3oT6L@wuerfel>	<CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>	<1432285588.3929.28.camel@pengutronix.de>	<20150522091822.GF8557@lukather>	<1432289231.3929.60.camel@pengutronix.de>
 <CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>
Message-ID: <555F2A8A.5020205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.05.2015 um 14:32 schrieb Maxime Coquelin:
> 2015-05-22 12:07 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> The STM32F427xx/STM32F429xx manual, Table 13. "STM32F427xx and
>> STM32F429xx register boundary addresses" contains this entry:
>>     Bus    Boundary address       Peripheral
>>     AHB1   0x40023800-0x400238bf  RCC
>>
>> And that's how I'd expect it to be described by the device tree:
>>
>>     rcc: rcc at 40023800 {
>>         compatible = "st,stm32-rcc";
>>         reg = <0x40023800 0xc0>;
>>     };
>>
> 
> Doing that, since this register bank contains both reset and clock
> registers, the reset device cannot get the IO resource at probe time
> because the clock driver has already reserved it.
> Daniel, who has started to work on the clock driver is facing this issue.
> This is why I proposed this binding for "reg" property.

As you should know, I did have an RCC clk driver, and there is no such
issue. The two drivers use different mechanisms for initialization. And
I'm pretty sure that I've already remarked that on the list, too.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
