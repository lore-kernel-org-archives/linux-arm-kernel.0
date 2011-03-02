From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 2 Mar 2011 19:41:45 +0000
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <8762s1xqmj.fsf@lebrac.rtp-net.org>
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	<8762s1xqmj.fsf@lebrac.rtp-net.org>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA18A7C0@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,


>-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
>bounces at lists.infradead.org] On Behalf Of Arnaud Patard
>Sent: Wednesday, March 02, 2011 1:35 PM
>To: Nguyen Dinh-R00091
>Cc: linux at arm.linux.org.uk; s.hauer at pengutronix.de; linux-kernel at vger.kernel.org; u.kleine-
>koenig at pengutronix.de; Zhang Lily-R58066; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
>
><Dinh.Nguyen@freescale.com> writes:
>
>Hi,
>
>> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>>
>> Adds initial low power suspend functionality to MX51.
>> Supports "mem" and "standby" modes.
>
>I've very quickly tried suspend to mem on my system and despite having set
>some irq as wakeup source, it doesn't wake up. Is there some extra step
>to be done in order to test your patch ?
>
>Moreover, the code I've seen for suspend is very different. It's seems
>to handle some cpufreq stuff and seems to be copying some code into some
>special ram. Is all this stuff unneeded ?

I am able to wakeup using gpio-key on my mx51-babbage system if I comment out the most of the drivers except for the gpio-keys driver. Yes, there are additional cpufreq and code that needs to get run in IRAM for mx51, which I will add on to this patch. This is just the initial patch to put the SoC in to suspend and have other developers add to it.

Thanks,

Dinh

>
>Arnaud
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
