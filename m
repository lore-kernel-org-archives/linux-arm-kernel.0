From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 7 Mar 2011 20:29:17 +0000
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <87fwqyvrzf.fsf@lebrac.rtp-net.org>
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	<87oc5puwg3.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
	<87fwqyvrzf.fsf@lebrac.rtp-net.org>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA194786@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnaud,


>-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
>bounces at lists.infradead.org] On Behalf Of Arnaud Patard
>Sent: Monday, March 07, 2011 10:02 AM
>To: Nguyen Dinh-R00091
>Cc: linux at arm.linux.org.uk; s.hauer at pengutronix.de; linux-kernel at vger.kernel.org; Vaidyanathan
>Ranjani-RA5478; u.kleine-koenig at pengutronix.de; Zhang Lily-R58066; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
>
>Nguyen Dinh-R00091 <R00091@freescale.com> writes:
>
>> Hi Arnaud,
>
>Hi,
>>
>> Just to verify that you are testing on an MX51-Babbage board? Here's my log:
>
>I never said I was testing on babbage. The reason is because I'm using a
>efika smartbook and not a babbage.
>
>>
>> root at freescale ~$ uname -a
>> Linux freescale 2.6.38-rc1+ #93 Fri Mar 4 17:18:15 CST 2011 armv7l GNU/Linux
>
>2.6.38-rc1+ ? which tree are you using ? The for-next branch of Sascha
>Hauer's tree is at least 2.6.38-rc5 so you're trying to merge something
>without even testing it on the current tree. Can you please test suspend
>with current imx for-next tree (with no other patches than theses 2
>patches if possible), in order to make sure that it's still working with it ?
>

I just tested the same 2 patches on Sascha's imx for-next branch and its working fine. I used a lab power supply to measure that the system did indeed suspend and wakeup. When the Babbage is running at 5V, its drawing 900 mA, after putting the system in suspend, it draws 200 mA.

And I can wakeup just fine using a irq from a gpio. Perhaps you IRQ source is not capable of waking up the system?

Dinh

>Thanks,
>Arnaud
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
