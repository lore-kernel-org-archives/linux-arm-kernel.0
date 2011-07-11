From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Jul 2011 08:32:38 +0200
Subject: [PATCH 2/6] spi/imx: use soc name in spi device type naming scheme
In-Reply-To: <20110709070001.GE13962@S2100-06.ap.freescale.net>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
	<20110708105851.GF6069@pengutronix.de>
	<20110709070001.GE13962@S2100-06.ap.freescale.net>
Message-ID: <20110711063238.GL6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2011 at 03:00:02PM +0800, Shawn Guo wrote:
> On Fri, Jul 08, 2011 at 12:58:51PM +0200, Sascha Hauer wrote:
> > On Fri, Jul 08, 2011 at 04:27:30PM +0800, Shawn Guo wrote:
> > > Software defined version number is not stable enough to be used
> > > in device type naming scheme.  The patch changes it to use implicit
> > > soc name for spi device type definition.  In this way, we can easily
> > > align the naming scheme with device tree binding, which comes later.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >  arch/arm/mach-imx/clock-imx25.c              |    7 +-
> > >  arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
> > >  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
> > >  drivers/spi/Kconfig                          |   15 -
> > >  drivers/spi/spi-imx.c                        |  423 ++++++++++++--------------
> > >  5 files changed, 219 insertions(+), 249 deletions(-)
> > 
> > Generally this patch is too big for me to get the warm feeling that
> > everything will just work. Renaming from spi_ver_xy to imx_xy is fine,
> > but should be done in smaller steps and where possible not across
> > subsystems.
> > 
> Okay, I will split the patch into small pieces to win your warm
> feeling :)
> 
> > I increasingly see patches touching arch/ and drivers/ and I think
> > there's a high risk of merge conflicts upstream. This will not help
> > making Linus happy.
> > 
> Yes, I increasingly run into the situation touching arch/ and drivers/
> when working on dt migration because of the device renaming.  May I
> have to your suggestion on how to separate drivers/ patch from arch/
> one in orthogonal way, while keeping both trees working/bisectable?

You could for example keep the platform bindings for the old names and
just add new ones. Then, when all patches are in, remove the old
bindings. Of course this slows down things. You could also do all
necessary preparations and do the actual renaming of the devices during
-rc time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
