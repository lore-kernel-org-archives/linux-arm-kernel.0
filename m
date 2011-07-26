From: davidb@codeaurora.org (David Brown)
Date: Tue, 26 Jul 2011 14:39:10 -0700
Subject: [PATCHv2 2/2] ARM: ARM_PATCH_PHYS_VIRT_16BIT no longer depends
	on MSM
In-Reply-To: <alpine.LFD.2.00.1107261418250.12766@xanadu.home>
References: <1311614362-9011-1-git-send-email-sboyd@codeaurora.org>
	<1311614362-9011-2-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1107251624560.12766@xanadu.home>
	<20110725203114.GF14955@n2100.arm.linux.org.uk>
	<4E2EFC0E.8020805@codeaurora.org>
	<alpine.LFD.2.00.1107261418250.12766@xanadu.home>
Message-ID: <20110726213910.GA11358@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 02:24:26PM -0400, Nicolas Pitre wrote:
> On Tue, 26 Jul 2011, Stephen Boyd wrote:
> 
> > On 07/25/2011 01:31 PM, Russell King - ARM Linux wrote:
> > > On Mon, Jul 25, 2011 at 04:25:26PM -0400, Nicolas Pitre wrote:
> > >> On Mon, 25 Jul 2011, Stephen Boyd wrote:
> > >>
> > >>> MSM no longer requires the 16bit version of dynamic P2V. Drop the
> > >>> dependency.
> > >>>
> > >>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > >>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > >>> Cc: David Brown <davidb@codeaurora.org>
> > >> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > As it's now unused, we can kill the additional code which makes things
> > > needlessly more complex...
> > 
> > Ok. I'll remove the extra code in v3.
> 
> Something like this (untested):
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S

I've tested this on MSM8660.  Works with CONFIG_ARM_PATCH_PHYS_VIRT
enabled (but an offset of zero).

I'd like to make this up into a patch, Nicolas, do you want to be the
author (and do you sign-off)?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
