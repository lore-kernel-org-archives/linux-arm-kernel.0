From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Sep 2011 09:24:19 +0800
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <20110906202555.GQ28816@pengutronix.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
Message-ID: <20110915012417.GC1488@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Sep 06, 2011 at 10:25:55PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Sep 06, 2011 at 05:58:36PM +0800, Shawn Guo wrote:

[...]

> > diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
> > index 066d464..341f800 100644
> > --- a/arch/arm/plat-mxc/include/mach/entry-macro.S
> > +++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
> > @@ -1,6 +1,6 @@
> >  /*
> >   *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
> > - *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *  Copyright 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> >   */
> >  
> >  /*
> > @@ -11,6 +11,17 @@
> >  
> >  #include <mach/hardware.h>
> >  
> > +#ifdef CONFIG_ARM_GIC
> > +#include <asm/hardware/entry-macro-gic.S>
> > +
> > +	.macro	disable_fiq
> > +	.endm
> > +
> > +	.macro	arch_ret_to_user, tmp1, tmp2
> > +	.endm
> > +
> > +#else
> > +
> hmm, this essentially means mx6 support cannot go into a kernel image
> for the other imx machines :-(
> 
I thought you gave this comment because imx6q change breaks the existing
support for single image.  But looking at the code a little bit closer,
I found that even the coexisting of AVIC and TZIC have not been
supported.  That said imx6q change did not make the situation any worse,
and we should come up with a solution later than this series to build
AVIC, TZIC and GIC in single image.

-- 
Regards,
Shawn
