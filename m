From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 5 Nov 2010 00:01:44 +0800
Subject: [PATCH] ARM: pxa: fix the building failue on saar
In-Reply-To: <20101104155735.GE16938@pengutronix.de>
References: <1288882401-14859-1-git-send-email-haojian.zhuang@marvell.com>
	<20101104155735.GE16938@pengutronix.de>
Message-ID: <AANLkTim0PNgnwOkiqCKhLFq1K29r04X=GqtaTQTngouX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/4 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Nov 04, 2010 at 10:53:21PM +0800, Haojian Zhuang wrote:
>> Since CONFIG_FB_PXA_SMARTPANEL is introduced and it's depend on CONFIG_FB_PXA.
>> We can't compile CONFIG_FB_PXA as module.
> I don't know if choosing CONFIG_FB_PXA=m without
> CONFIG_FB_PXA_SMARTPANEL makes sense. ?If yes, just letting
> CONFIG_FB_PXA_SMARTPANEL depend on CONFIG_FB_PXA=y should work.
>
> If this doesn't work (e.g. because arch/arm/mach-pxa/saar.c calls
> functions that are only available in the fb_pxa kernel module) there is
> no need to talk about CONFIG_FB_PXA_SMARTPANEL in the commit log, this
> only confuses the readers.
>

Haojian,

I don't like the Kconfig change to make FB_PXA non-tristate as well.
Please see if there's better solution.

> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
