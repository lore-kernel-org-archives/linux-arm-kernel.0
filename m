From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 25 Nov 2010 16:01:04 +0800
Subject: [PATCH 1/1] arm: imx: share imx5x_register_gpios for mach-mx5
In-Reply-To: <20101125074244.GE4693@pengutronix.de>
References: <1290695312-30031-1-git-send-email-linuxzsc@gmail.com>
	<20101125062924.GD4693@pengutronix.de>
	<AANLkTimvcAS3BmjtaYCMzHcv=q2znS2zy_Dto_OMJeWh@mail.gmail.com>
	<20101125074244.GE4693@pengutronix.de>
Message-ID: <AANLkTikZkXRmddSYN0-7eSBKO_BpXbz+xuJRhDfKeU02@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/25 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hey Richard,
>
> On Thu, Nov 25, 2010 at 02:44:48PM +0800, Richard Zhao wrote:
>> > IMO the machine files shouldn't need to know how many gpio banks are
>> > available. ?This is a per-SoC thing and so should be set in a SoC function.
>> But we don't have SoC level device file.
> Check how I did it for imx{1,21,27,25} in arch/arm/plat-mxc/gpio.c.
I considered put it there too. but we can not add new defconfig, and
even can not create new items in Kconfig. So we can not use ifdefs.
And per my understanding, mx5x is going to use one zImage, correct?
>
>> > How do you want to continue this change? ?mx51 and mx53 have the same
>> > number of ports? ?Does mx50 have more or less? ?The addresses are the
>> > same?
>> mx53 and mx50 have similar memory map. but mx51 is different. ?Sorry,
>> I forgot upstream version IO_ADDR can not handler differnt SoC base
>> addr offset.
> It might even work in this case, still I prefer a more explicit way.
>
>> ? ? ? ? ? ? ?It can not be shared with mx51, but it can be shared with
>> mx50/53, correct? May plan is mx53/50 share
>> arch/arm/plat-mxc/include/mach/mx5x.h file.
> mx5x.h is for mx50 and mx53 but not mx51? ?No please.
For memory map, mx51 is a special case. From mx53 on , IC tuned memory
map to support large memory.
If we use things like mx53-50.h, symbols is hard to define.
MX53_50_XXX_XXX is wired. Any possibly, we need to add new SoC with
similar memory map in the future.

Thanks
Richard
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
