From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Jun 2010 14:36:39 +0100
Subject: [PATCH] S5PV210: Increase the VIC_NR as 4
In-Reply-To: <20100603103144.GA7127@n2100.arm.linux.org.uk>
References: <20100603100954.GA17434@july>
	<20100603103144.GA7127@n2100.arm.linux.org.uk>
Message-ID: <20100603133639.GR7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 11:31:44AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 03, 2010 at 07:09:54PM +0900, Kyungmin Park wrote:
> > The S5PV210 SoC have 4 VICs. It requires for suspend and resume.
> 
> Isn't this negated by Ben's "ARM: VIC: Allocate VIC PM device from slab"
> patch?

I was awaiting the feedback from other archs which I don't have access
to... 
 
> Incidentally, shouldn't Ben's patch remove this configuration option too?

Yes, you're right, should have removed these.

> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> > diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> > index 0a34c81..0ac3d81 100644
> > --- a/arch/arm/common/Kconfig
> > +++ b/arch/arm/common/Kconfig
> > @@ -6,6 +6,7 @@ config ARM_VIC
> >  
> >  config ARM_VIC_NR
> >  	int
> > +	default 4 if ARCH_S5PV210
> >  	default 2
> >  	depends on ARM_VIC
> >  	help
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
