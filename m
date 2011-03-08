From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Mar 2011 18:18:26 +0800
Subject: [PATCH 0/4] Add framebuffer device for mx28evk and mx23evk boards
In-Reply-To: <20110307081837.GJ29521@pengutronix.de>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
	<20110307081837.GJ29521@pengutronix.de>
Message-ID: <20110308101825.GC21188@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Mar 07, 2011 at 09:18:37AM +0100, Sascha Hauer wrote:
> On Sun, Mar 06, 2011 at 12:40:18AM +0800, Shawn Guo wrote:
> > This patch set is to add framebuffer device for mx28evk and mx23evk
> > boards.  A couple notes here:
> > 
> > * The patch [PATCH 3/4] was cherry-picked from mxs-mmc-device patch
> >   set  (Sascha, it seems dma, mmc, flexcan platform patches are all
> >   waiting for your merging, please let me know if there are still
> >   something stopping your pick them up)
> 
> I just applied dma and flexcan. mmc will have to wait until the

I'm rebasing my mx28evk framebuffer patch set, and found the following
one was missing from the flexcan merging.

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 895d066..cdbe18b 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -33,6 +33,7 @@ config MACH_MX28EVK
        select MXS_HAVE_AMBA_DUART
        select MXS_HAVE_PLATFORM_AUART
        select MXS_HAVE_PLATFORM_FEC
+       select MXS_HAVE_PLATFORM_FLEXCAN
        select MXS_OCOTP
        default y
        help

> mmc driver is merged because currently we do not have the platform_data
> declaration.

-- 
Regards,
Shawn
