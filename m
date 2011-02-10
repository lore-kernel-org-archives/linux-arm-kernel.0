From: B20596@freescale.com (Li Frank-B20596)
Date: Thu, 10 Feb 2011 12:23:21 +0000
Subject: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
In-Reply-To: <201102101212.17370.jbe@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102101052.10958.jbe@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167988@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102101212.17370.jbe@pengutronix.de>
Message-ID: <09EC74FE2C9E8444BF2FF67BD36E1D691679E4@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> What about?
> > Reg &= ~VDCTRL4_SET_DOTCLK_DLY(0x7);
> Or?
> > Reg &= ~VDCTRL4_SET_DOTCLK_DLY_MASK;
> Okay, the even get longer and longer.

If use 0x7, you have to take care bit width. 
If use VDCTRL4_SET_DOTCLK_DLY_MASK, I think BF_ and BM_ is better. 

> > Reg |= VDCTRL4_SET_DOTCLK_DLY(value)
> > Writel(reg, offset+VDCTRL4)
> >
> > Compared with our macro policy.
> >
> > Reg = readl(offset+HW_VDCTRL4);
> > Reg &=~ BM_VDCTRL4_SET_DOTCLK_DLY;
> > Reg |= BF_VDCTRL4_SET_DOTCLK_DLY(value)
> > Writel(reg, offset+HW_VDCTRL4)
> 
> Anywhere else such naming policy in the kernel? I have to deal with all
> kind
> of CPUs, not only i.MX23/28.

This driver is for mx23/mx28. 
I have not found such policy in the kernel, otherwise I have generated that at beginning. 
It is better if all of mx23/mx28 driver follow the same role. 
