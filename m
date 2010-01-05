From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Jan 2010 04:13:41 -0500
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <f17812d71001042330p21da40dcr7b29a1316cf9a615@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
	<771cded01001031827j28dc6aa9l5425669f2ceeb27a@mail.gmail.com>
	<f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
	<771cded01001031929w688217d3g257b395f7544ee7a@mail.gmail.com>
	<f17812d71001032027k17dba375pd29ccbca17034a46@mail.gmail.com>
	<771cded01001040215g55a09005ra8248005fb396a1e@mail.gmail.com>
	<20100104102740.GA9107@n2100.arm.linux.org.uk>
	<771cded01001040316j58e07a74gae37e0cabcd60f26@mail.gmail.com>
	<f17812d71001042330p21da40dcr7b29a1316cf9a615@mail.gmail.com>
Message-ID: <771cded01001050113y44551a12i7a03009f62108f8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 5, 2010 at 2:30 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> OK. Update the patches.
>>
>
> Applied to branch 'mmp2' and made some changes as follows
> (please let me know your concerns and help test this):
>
> 1. irq-mmp2.c: separate the difference into different irq_chip
> and individual demux handler for those MUXed IRQs, naming
> is changed a bit as well. Having a single irq_chip and demux
> handler isn't performance friendly - having to go through a lengthy
> condition branches each time - and that's why irq_chip is invented.
>
> 2. merge patch 1, 2, 3 together so mmp2 can build (my build
> here complains about no machine_desc defined if flint support
> isn't there)
>
> And I'd like you to help co-maintaine MMP2 together with me,
> please kindly Ack if you're fine with the patch follows:
>
> commit 2004b15682f0f612b85088d730164e91fca2eec8
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date: ? Tue Jan 5 15:28:26 2010 +0800
>
> ? ?MAINTAINERS: add maintainers for Marvell MMP2 (aka ARMADA610) support
>
> ? ?Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> ? ?Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66f5f7d..33978ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4439,6 +4439,13 @@ L: ? ? ? linux-arm-kernel at lists.infradead.org
> (moderated for non-subscribers)
> ?T: ? ? git git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> ?S: ? ? Maintained
>
> +MMP2 SUPPORT (aka ARMADA610)
> +M: ? ? Haojian Zhuang <haojian.zhuang@marvell.com>
> +M: ? ? Eric Miao <eric.y.miao@gmail.com>
> +L: ? ? linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +T: ? ? git git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> +S: ? ? Maintained
> +
> ?PXA MMCI DRIVER
> ?S: ? ? Orphan
>

Acked.

Best Regards
Haojian
