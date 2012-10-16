From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 11:07:55 -0700
Subject: [PATCH] ARM: OMAP: resolve sparse warning concerning
 debug_card_init()
In-Reply-To: <50751D36.9020001@compulab.co.il>
References: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
 <50751D36.9020001@compulab.co.il>
Message-ID: <20121016180754.GB15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [121010 00:02]:
> On 10/09/12 22:29, Paul Walmsley wrote:
> > 
> > Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> > debug_card_init() function") results in the following new sparse
> > warning:
> > 
> > arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> > 
> > Fix by implementing Tony's suggestion to add a "sideways include" to the
> > new location of the debug-devices.h file in arch/arm/mach-omap2/.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, applying into omap-for-v3.7-rc1/fixes-part2.

Regards,

Tony
 
> > ---
> >  arch/arm/plat-omap/debug-devices.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
> > index c7a4c09..5a4678e 100644
> > --- a/arch/arm/plat-omap/debug-devices.c
> > +++ b/arch/arm/plat-omap/debug-devices.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/smc91x.h>
> >  
> >  #include <mach/hardware.h>
> > +#include "../mach-omap2/debug-devices.h"
> >  
> >  /* Many OMAP development platforms reuse the same "debug board"; these
> >   * platforms include H2, H3, H4, and Perseus2.
> 
> -- 
> Regards,
> Igor.
