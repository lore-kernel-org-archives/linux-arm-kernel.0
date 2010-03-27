From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 17:02:47 +0100
Subject: [PATCH 1/7 v2] Introduce plat-tcc
In-Reply-To: <20100325203107.GB24984@n2100.arm.linux.org.uk>
References: <20100325200427.GC2047@bluebox.local>
	<20100325200746.GD2047@bluebox.local>
	<20100325203107.GB24984@n2100.arm.linux.org.uk>
Message-ID: <20100327160247.GB2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:31:07PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 09:07:48PM +0100, Hans J. Koch wrote:
> > +#define __virt_to_bus(x)	__virt_to_phys(x)
> > +#define __bus_to_virt(x)	__phys_to_virt(x)
> > +#define __pfn_to_bus(x)		__pfn_to_phys(x)
> > +#define __bus_to_pfn(x)		__phys_to_pfn(x)
> 
> You don't need to define any of these.

Right. Removed.

> 
> > diff --git a/arch/arm/plat-tcc/include/mach/vmalloc.h b/arch/arm/plat-tcc/include/mach/vmalloc.h
> > new file mode 100644
> > index 0000000..9635303
> > --- /dev/null
> > +++ b/arch/arm/plat-tcc/include/mach/vmalloc.h
> > @@ -0,0 +1,11 @@
> > +/*
> > + * Author: <linux@telechips.com>
> > + * Created: June 10, 2008
> > + *
> > + * Copyright (C) 2000 Russell King.
> > + * Copyright (C) 2008-2009 Telechips
> > + *
> > + * Licensed under the terms of the GPL v2.
> > + */
> > +#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)
> 
> Base address of IO rather than something dependent on PAGE_OFFSET?

Fixed.

> 
> > +
> > diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
> > new file mode 100644
> > index 0000000..1a33ced
> > --- /dev/null
> > +++ b/arch/arm/plat-tcc/system.c
> > @@ -0,0 +1,24 @@
> > +/*
> > + * System functions for Telechips TCCxxxx SoCs
> > + *
> > + * Copyright (C) Hans J. Koch <hjk@linutronix.de>
> > + *
> > + * Licensed under the terms of the GPL v2.
> > + *
> > + */
> > +
> > +#include <asm/io.h>
> 
> linux/io.h ?

OK.

Thanks,
Hans
