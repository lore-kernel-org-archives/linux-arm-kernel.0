From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 08:01:23 +0000
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <20120919032337.GU8832@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <201209171430.35804.arnd@arndb.de>
 <20120919032337.GU8832@opensource.wolfsonmicro.com>
Message-ID: <201209190801.23616.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Mark Brown wrote:
> On Mon, Sep 17, 2012 at 02:30:35PM +0000, Arnd Bergmann wrote:
> > On Monday 17 September 2012, Mark Brown wrote:
> > > On Mon, Sep 17, 2012 at 01:34:45PM +0800, Shawn Guo wrote:
> 
> > > >  #include <linux/platform_data/asoc-imx-ssi.h>
> > > > -#include <mach/hardware.h>
> 
> > > This doesn't apply - there's no platform data header for imx-ssi at the
> > > minute (and I don't see a patch in this series related to that in the
> > > series).  I checked -next and there doesn't seem to be anything via a
> > > non-ASoC tree either.
> 
> > It's in my testing/platform-data series, and will be in linux-next in
> > a few days.
> 
> Hrm, that seems odd - why are we adding platform data to the driver?

We're not adding it, we just rename the header file from mach/imx.h
to linux/platform-data/asoc-imx-ssi.h, along with 94 other header files
that get moved to the same directory.

	Arnd
