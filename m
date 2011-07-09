From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 9 Jul 2011 15:00:02 +0800
Subject: [PATCH 2/6] spi/imx: use soc name in spi device type naming scheme
In-Reply-To: <20110708105851.GF6069@pengutronix.de>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
	<20110708105851.GF6069@pengutronix.de>
Message-ID: <20110709070001.GE13962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 12:58:51PM +0200, Sascha Hauer wrote:
> On Fri, Jul 08, 2011 at 04:27:30PM +0800, Shawn Guo wrote:
> > Software defined version number is not stable enough to be used
> > in device type naming scheme.  The patch changes it to use implicit
> > soc name for spi device type definition.  In this way, we can easily
> > align the naming scheme with device tree binding, which comes later.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  arch/arm/mach-imx/clock-imx25.c              |    7 +-
> >  arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
> >  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
> >  drivers/spi/Kconfig                          |   15 -
> >  drivers/spi/spi-imx.c                        |  423 ++++++++++++--------------
> >  5 files changed, 219 insertions(+), 249 deletions(-)
> 
> Generally this patch is too big for me to get the warm feeling that
> everything will just work. Renaming from spi_ver_xy to imx_xy is fine,
> but should be done in smaller steps and where possible not across
> subsystems.
> 
Okay, I will split the patch into small pieces to win your warm
feeling :)

> I increasingly see patches touching arch/ and drivers/ and I think
> there's a high risk of merge conflicts upstream. This will not help
> making Linus happy.
> 
Yes, I increasingly run into the situation touching arch/ and drivers/
when working on dt migration because of the device renaming.  May I
have to your suggestion on how to separate drivers/ patch from arch/
one in orthogonal way, while keeping both trees working/bisectable?

-- 
Regards,
Shawn
