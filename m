From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 6 Jun 2011 20:22:19 +0800
Subject: [PATCH v4 0/2] Move plat-mxc gpio driver into drivers/gpio
In-Reply-To: <20110606085051.GA23771@pengutronix.de>
References: <1307290075-7062-1-git-send-email-shawn.guo@linaro.org>
	<20110606085051.GA23771@pengutronix.de>
Message-ID: <20110606122219.GC21204@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 10:50:51AM +0200, Sascha Hauer wrote:
> On Mon, Jun 06, 2011 at 12:07:53AM +0800, Shawn Guo wrote:
> > The patch set moves plat-mxc gpio driver into drivers/gpio, and
> > migrates mach-imx and mach-mx5 to the new driver.
> > 
> > Changes since v3:
> >  * Reorganize the patch set per Grant's comments
> > 
> > Shawn Guo (2):
> >       gpio/mxc: Move Freescale MXC gpio driver to drivers/gpio
> >       gpio/mxc: Change gpio-mxc into an upstanding gpio driver
> > 
> >  arch/arm/plat-mxc/include/mach/common.h            |   12 +-
> >  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +
> >  arch/arm/plat-mxc/include/mach/gpio.h              |   27 ---
> >  drivers/gpio/Kconfig                               |    4 +
> >  drivers/gpio/Makefile                              |    1 +
> >  .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |  217 +++++++++++++-------
> 
> While at renaming I'd prefer naming this file gpio-imx.c. We currently
> have inconsistent naming between mxc vs. imx and I'd like to get rid
> of the former.
> 
It's not just a file name.  The "mxc" is embedded in the variable
and function name all over the driver.  I would currently keep it as
it is for the reasons below.

 * The driver was moved out from plat-mxc, so naturally the name
   gpio-mxc is picked.

 * Changing name to gpio-imx would require replace all "mxc" with
   "imx" all over the file, IMO.  This makes the diff of the patch
   look complex.

 * i.MX23 and i.MX28 are also part of imx family, but architecture
   name "imx" does not cover it.  Taking "mxs" as the architecture name 
   for i.MX23 and i.MX28, "mxc" stands well what it stands right now.

I would start renaming the driver with another patch, probably when
I see mach-mx5 start getting merged into mach-imx and plat-mxc renamed
to plat-imx.

-- 
Regards,
Shawn
