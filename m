From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 8 Dec 2011 08:19:12 +0000
Subject: [PATCH] arm,davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <4EE06B79.7070804@denx.de>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B603EFB2@DBDE01.ent.ti.com>
 <4EE06B79.7070804@denx.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6040A03@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 13:17:05, Heiko Schocher wrote:

> >> diff --git a/Documentation/devicetree/bindings/arm/davinci/aemif.txt b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
> >> new file mode 100644
> >> index 0000000..c9ed551
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
> >> @@ -0,0 +1,85 @@
> >> +* Texas Instruments Davinci AEMIF
> >> +
> >> +This file provides information, what the device node for the
> >> +davinci aemifa interface contain.
> >            ^^^^^^
> >            aemif
> 
> fixed, thanks.
> 
> >> +
> >> +Required properties:
> >> +- compatible: "ti,davinci-emifa";
> 
> Shouldn't this also be "ti,davinci-aemif" ?

Yes, makes sense.

> 
> [...]
> >> diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
> >> index 1ce70a9..12c559f 100644
> >> --- a/arch/arm/mach-davinci/aemif.c
> >> +++ b/arch/arm/mach-davinci/aemif.c
> >> @@ -13,12 +13,14 @@
> >>  #include <linux/err.h>
> >>  #include <linux/clk.h>
> >>  #include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >>  #include <linux/time.h>
> >>  
> >>  #include <mach/aemif.h>
> >>  
> >>  /* Timing value configuration */
> >> -
> >> +#define ASIZE(x)	(x)
> >>  #define TA(x)		((x) << 2)
> >>  #define RHOLD(x)	((x) << 4)
> >>  #define RSTROBE(x)	((x) << 7)
> >> @@ -26,7 +28,10 @@
> >>  #define WHOLD(x)	((x) << 17)
> >>  #define WSTROBE(x)	((x) << 20)
> >>  #define WSETUP(x)	((x) << 26)
> >> +#define EW(x)		((x) << 30)
> >> +#define SS(x)		((x) << 31)
> > 
> > You are adding support for additional configuration
> > parameters which should be done in a separate patch.
> 
> Hmm.. they are only used in the OF case ... is this split
> really needed?

But they should also be useful in the non-OF case, no?
Why restrict their usage to the OF case?

Thanks,
Sekhar
