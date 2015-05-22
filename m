From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 22 May 2015 15:14:53 +0100
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CALszF6A=TZ_EROrfuBOAGiY3mbydC5fepWLSWrZLLt4nV9sr4w@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<2282066.NWoIT9ZyLc@wuerfel>	<CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>	<13641152.Yt4ZI3oT6L@wuerfel>	<CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>	<1432285588.3929.28.camel@pengutronix.de>	<20150522091822.GF8557@lukather>	<1432289231.3929.60.camel@pengutronix.de>	<CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>	<555F2A8A.5020205@suse.de>
 <CALszF6A=TZ_EROrfuBOAGiY3mbydC5fepWLSWrZLLt4nV9sr4w@mail.gmail.com>
Message-ID: <555F39DD.9060209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/15 14:57, Maxime Coquelin wrote:
> 2015-05-22 15:09 GMT+02:00 Andreas F?rber <afaerber@suse.de>:
>> As you should know, I did have an RCC clk driver, and there is no such
>> issue. The two drivers use different mechanisms for initialization. And
>> I'm pretty sure that I've already remarked that on the list, too.
>
> Yes, you use of_iomap in your clock driver [0].
> Daniel, would you accept to do the same?
> That would remove one difference between stm32/sunxi/socfpga reset drivers.

In fact, that is exactly what I am currently doing, though I was 
planning for it to be temporary.

It seems a bit weird to me that one driver (which requests too much 
register space) only works because another driver chooses not to request 
any.

BTW in drivers/clk there are ~110 of_iomaps and only 10 
of_io_request_and_maps... so I don't think anyone will yell at me for 
using of_iomap().


Daniel.
