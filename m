From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 09:56:14 +0800
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140721094452.GD16122@arm.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
 <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
 <20140721085150.GB15666@arm.com> <20140721092703.GL8537@dragon>
 <20140721094452.GD16122@arm.com>
Message-ID: <20140722015613.GN8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 10:44:52AM +0100, Will Deacon wrote:
> > > > @@ -54,7 +55,7 @@ void scu_enable(void __iomem *scu_base)
> > > >  	if (scu_ctrl & SCU_ENABLE)
> > > >  		return;
> > > >  
> > > > -	scu_ctrl |= SCU_ENABLE;
> > > > +	scu_ctrl |= SCU_ENABLE | SCU_STANDBY_ENABLE;
> > > 
> > > I don't think this bit exists on all revisions of the A9.
> > 
> > Thanks for the info, Will.  Is there any side-effect to write the
> > standby bit on those revisions which do not define the bit?
> 
> I'm not actually sure what happens at the hardware level, but the TRM is
> pretty clear in its definition of `RESERVED':
> 
>  `All reserved bits not used by the implementation must be written as 0 and
>   read as 0.'

Okay.  Can you please tell which revisions of A9 do not implement this
standby bit, so that I can check and skip them?  The oldest revision I
can find on http://infocenter.arm.com/ is r2p0, which already implements
the bit.

Shawn
