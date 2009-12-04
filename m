From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Dec 2009 12:28:11 +0100
Subject: [RFC][PATCH 04/10] arm: mxc: Fix Drive Strength Field in the
	IOMUX controller
In-Reply-To: <20091204093824.GB10910@pengutronix.de>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
	<20091204093824.GB10910@pengutronix.de>
Message-ID: <20091204112811.GN15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 10:38:24AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Dec 04, 2009 at 04:47:04AM +0200, Amit Kucheria wrote:
> > i.MX51 defines 4 values:
> > 
> > 00: Low Drive Strength
> > 01: Medium Drive Strength
> > 10: High Drive Strength
> > 11: Max Drive Strength
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> > ---
> >  arch/arm/plat-mxc/include/mach/iomux-v3.h |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> > index a0fa402..8c351d6 100644
> > --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> > +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> > @@ -81,11 +81,13 @@ struct pad_desc {
> >  
> >  #define PAD_CTL_ODE			(1 << 3)
> >  
> > -#define PAD_CTL_DSE_STANDARD		(0 << 1)
> > -#define PAD_CTL_DSE_HIGH		(1 << 1)
> > -#define PAD_CTL_DSE_MAX			(2 << 1)
> > +#define PAD_CTL_DSE_LOW			(0 << 1)
> > +#define PAD_CTL_DSE_MED			(1 << 1)
> > +#define PAD_CTL_DSE_HIGH		(2 << 1)
> > +#define PAD_CTL_DSE_MAX			(3 << 1)
> Does the new values work on other SOCs having iomux-v3, too?

They should work. on i.MX35 (2 << 1) and (3 << 1) are both max driving
strength. It's only that the names change, but these macros are unused
currently, so this shouldn't hurt.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
