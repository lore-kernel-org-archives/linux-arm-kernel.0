From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 08:55:35 -0800
Subject: [PATCH 1/3] ARM: OMAP2+: Prepare to move GPMC to drivers by
 platform data header
In-Reply-To: <20141121161529.GQ7046@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-2-git-send-email-tony@atomide.com>
 <546F05C3.6090508@ti.com> <20141121161529.GQ7046@atomide.com>
Message-ID: <20141121165535.GT7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141121 08:18]:
> * Roger Quadros <rogerq@ti.com> [141121 01:30]:
> > On 11/21/2014 12:28 AM, Tony Lindgren wrote:
> > > +#include <linux/omap-gpmc.h>
> > > +#include <linux/platform_data/omap-gpmc.h>
> > 
> > I think we should get rid for mach-omap2/gpmc.h and include the above two
> > headers wherever needed.
> 
> Well I'm trying to keep the churn on patching all board-*.c files
> down to minimum until they just get dropped.
> 
> So let's keep gpmc.h around still for a little while for all the
> board-*.c files.
>  
> > > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > > index 175564c..88721df 100644
> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/omap-dma.h>
> > > +#include <linux/omap-gpmc.h>
> > >  #include <linux/platform_data/gpio-omap.h>
> > >  
> > >  #include <trace/events/power.h>
> > > @@ -43,7 +44,6 @@
> > >  #include "common.h"
> > >  #include "cm3xxx.h"
> > >  #include "cm-regbits-34xx.h"
> > > -#include "gpmc.h"
> > >  #include "prm-regbits-34xx.h"
> > >  #include "prm3xxx.h"
> > >  #include "pm.h"
> 
> And for the files that will stay around, let's not include gpmc.h.

After updating this patch to remove include of gpmc.h in any files
this patch touches, we still have gpmc.h left in 11 files we're not
touching right now. If we want to patch those, we can do it later on
in a separate patch to avoid creating more dependencies between
branches.

Regards,

Tony
