From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 19:11:46 -0800
Subject: [PATCH 8/9] ARM: pxa: add 32KHz timer as clock source
In-Reply-To: <alpine.LFD.2.00.1011171019050.6448@xanadu.home>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
	<alpine.LFD.2.00.1011171019050.6448@xanadu.home>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C79AE@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Nicolas Pitre [mailto:nico at fluxnic.net]
>Sent: 2010?11?17? 11:23 PM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org; Eric Miao
>Subject: Re: [PATCH 8/9] ARM: pxa: add 32KHz timer as clock source
>
>On Wed, 17 Nov 2010, Haojian Zhuang wrote:
>
>> PXA silicons are using 3MHz timer as default clock source. But it'll be stopped
>> counting in low power mode. Although 32KHz timer is slow, it can continue
>> counting in low power mode. While low power mode is implemented as idle,
>> stopped timer can't be accepted.
>>
>> Add 32KHz timer as an alternative clock source. User can switch clock source
>> on demand.
>
>Do you need to do this for sched_clock() too?  The clock source API is
>for reliable clock, but sched_clock is not as strict and requires a fast
>and lightweight implementation instead.  And the clock source API and
>sched_clock() don't have to be based on the same timer.
>

Thanks for your comments. Now it's fixed in attachment.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0008-ARM-pxa-add-32KHz-timer-as-clock-source.patch
Type: application/octet-stream
Size: 9969 bytes
Desc: 0008-ARM-pxa-add-32KHz-timer-as-clock-source.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101117/604137fe/attachment.obj>
