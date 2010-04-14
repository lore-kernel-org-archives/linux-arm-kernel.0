From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Apr 2010 08:54:40 +0200
Subject: [PATCH 2.6.34-rc4 1/1] mx5: Fix build error for mx51_defconfig
In-Reply-To: <20100414064437.GA9919@matterhorn.verdurent.com>
References: <1271185508-7038-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20100414064437.GA9919@matterhorn.verdurent.com>
Message-ID: <20100414065440.GE7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 09:44:37AM +0300, Amit Kucheria wrote:
> On 10 Apr 13, Dinh.Nguyen at freescale.com wrote:
> > From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > 
> > Need to include <asm/div64.h> for do_div calls.
> > 
> > Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > ---
> >  arch/arm/mach-mx5/clock-mx51.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> > index 8f85f73..1ee6ce4 100644
> > --- a/arch/arm/mach-mx5/clock-mx51.c
> > +++ b/arch/arm/mach-mx5/clock-mx51.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/io.h>
> >  
> >  #include <asm/clkdev.h>
> > +#include <asm/div64.h>
> >  
> >  #include <mach/hardware.h>
> >  #include <mach/common.h>
> > -- 
> > 1.6.0.4
>  
> Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
> 
> Sascha, I can collect all the mx5 patches and make them available to you in a
> git pull-request. Would that be ok?

I prefer collecting them myself since many patches will be not i.MX51
specific but i.MX specific and I'm afraid of too many merge conflicts.

> 
> Regards,
> Amit
> p.s. Your patches are on my todo list. Will get to them now.

They are already mainline.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
