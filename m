From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Jan 2011 09:33:20 +0100
Subject: [PATCH v4 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20110113151939.GX24920@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-9-git-send-email-shawn.guo@freescale.com>
	<20110113151939.GX24920@pengutronix.de>
Message-ID: <20110114083320.GK26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 04:19:39PM +0100, Uwe Kleine-K?nig wrote:
> On Thu, Jan 06, 2011 at 03:13:16PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v4:
> >  - Call cpu_relax() during polling
> > 
> > Changes for v2:
> >  - Add mutex locking for mxs_read_ocotp()
> >  - Use type size_t for count and i
> >  - Add comment for clk_enable/disable skipping
> >  - Add ERROR bit clearing and polling step
> > 
> >  arch/arm/mach-mxs/Makefile              |    2 +-
> >  arch/arm/mach-mxs/include/mach/common.h |    1 +
> >  arch/arm/mach-mxs/ocotp.c               |   79 +++++++++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/ocotp.c
> > 
> > diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> > index 39d3f9c..f23ebbd 100644
> > --- a/arch/arm/mach-mxs/Makefile
> > +++ b/arch/arm/mach-mxs/Makefile
> > @@ -1,5 +1,5 @@
> >  # Common support
> > -obj-y := clock.o devices.o gpio.o icoll.o iomux.o system.o timer.o
> > +obj-y := clock.o devices.o gpio.o icoll.o iomux.o ocotp.o system.o timer.o
> is it worth to make ocotp optional?  (and let evk select
> CONFIG_MXS_OCOTP)

I think not.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
