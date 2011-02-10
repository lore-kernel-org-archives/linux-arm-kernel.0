From: B20596@freescale.com (Li Frank-B20596)
Date: Thu, 10 Feb 2011 10:08:04 +0000
Subject: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
In-Reply-To: <201102101046.33994.jbe@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102101046.33994.jbe@pengutronix.de>
Message-ID: <09EC74FE2C9E8444BF2FF67BD36E1D6916795C@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Li Frank-B20596 wrote:
> > > +
> > > +	/* if it was disabled, re-enable the mode again */
> > > +	reg = readl(host->base + CTRL);
> > > +	reg |= CTRL_DOTCLK_MODE;
> > > +	writel(reg, host->base + CTRL);
> >
> > writel(CTRL_DOTCLK_MODE, host->base + CTRL_SET)
> > CTRL_SET is CTRL+0x4
> > SET and CLR register is easier than Read and write back.
> 
> But you must always check, if the register really has such a SET and
> CLEAR
> feature. Not all registers have this feature...

That's a reason why I suggest use register header that generate from xml. 
HW_XX_CTRL_SET will exist if there are such register in hardware.
If hardware have not such register, there are not _SET and _CLR. 

Compiler will report error if user use _SET but hardware not such register. 

> 
> But in this case you are right.
> 
> But I would prefer:
> #define SET 4
> #define CLEAR 8
> [...]
> writel(CTRL_DOTCLK_MODE, host->base + CTRL + SET)
> :-)
> 
> Regards,
> Juergen
