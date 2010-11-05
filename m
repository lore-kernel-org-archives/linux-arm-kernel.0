From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Fri, 5 Nov 2010 01:22:14 -0700
Subject: [PATCH] ARM: pxa: fix the building failue on saar
In-Reply-To: <AANLkTim0PNgnwOkiqCKhLFq1K29r04X=GqtaTQTngouX@mail.gmail.com>
References: <1288882401-14859-1-git-send-email-haojian.zhuang@marvell.com>
	<20101104155735.GE16938@pengutronix.de>
	<AANLkTim0PNgnwOkiqCKhLFq1K29r04X=GqtaTQTngouX@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986429A2@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?5? 12:02 AM
>To: Uwe Kleine-K?nig
>Cc: Haojian Zhuang; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH] ARM: pxa: fix the building failue on saar
>
>2010/11/4 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> Hello,
>>
>> On Thu, Nov 04, 2010 at 10:53:21PM +0800, Haojian Zhuang wrote:
>>> Since CONFIG_FB_PXA_SMARTPANEL is introduced and it's depend on
>CONFIG_FB_PXA.
>>> We can't compile CONFIG_FB_PXA as module.
>> I don't know if choosing CONFIG_FB_PXA=m without
>> CONFIG_FB_PXA_SMARTPANEL makes sense. ?If yes, just letting
>> CONFIG_FB_PXA_SMARTPANEL depend on CONFIG_FB_PXA=y should work.
>>
>> If this doesn't work (e.g. because arch/arm/mach-pxa/saar.c calls
>> functions that are only available in the fb_pxa kernel module) there is
>> no need to talk about CONFIG_FB_PXA_SMARTPANEL in the commit log, this
>> only confuses the readers.
>>
>
>Haojian,
>
>I don't like the Kconfig change to make FB_PXA non-tristate as well.
>Please see if there's better solution.
>
>> Best regards
>> Uwe
>>
>> --
>> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
>> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>>

OK. Now I let saar and tavorevb depend on FB_PXA.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-pxa-fix-build-failure-in-saar-and-tavor.patch
Type: application/octet-stream
Size: 1477 bytes
Desc: 0001-ARM-pxa-fix-build-failure-in-saar-and-tavor.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101105/99e1d9e6/attachment.obj>
