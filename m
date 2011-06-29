From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Jun 2011 22:25:46 +0200
Subject: [PATCH] arm: mxs: include asm/processor.h for cpu_relax()
In-Reply-To: <20110629071026.GA22630@S2100-06.ap.freescale.net>
References: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
	<20110629071026.GA22630@S2100-06.ap.freescale.net>
Message-ID: <20110629202546.GN6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 03:10:27PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> Can you apply this patch on your for-next?

Done

Sascha

> 
> Regards,
> Shawn
> 
> On Wed, May 25, 2011 at 11:34:57AM +0200, Wolfram Sang wrote:
> > I get this build error as of today:
> > 
> > arch/arm/mach-mxs/ocotp.c: In function 'mxs_get_ocotp':
> > arch/arm/mach-mxs/ocotp.c:54: error: implicit declaration of function 'cpu_relax'
> > make[2]: *** [arch/arm/mach-mxs/ocotp.o] Error 1
> > 
> > Looks like it has been indirectly included before which broke now.
> > Include it directly.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/ocotp.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> > index 65157a3..54add60 100644
> > --- a/arch/arm/mach-mxs/ocotp.c
> > +++ b/arch/arm/mach-mxs/ocotp.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/err.h>
> >  #include <linux/mutex.h>
> >  
> > +#include <asm/processor.h>	/* for cpu_relax() */
> > +
> >  #include <mach/mxs.h>
> >  
> >  #define OCOTP_WORD_OFFSET		0x20
> > -- 
> > 1.7.2.5
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
