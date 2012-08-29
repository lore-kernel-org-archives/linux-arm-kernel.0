From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Aug 2012 11:49:57 +0200
Subject: [PATCH] ARM: tegra_defconfig: enable APB DMA support
In-Reply-To: <503DDEA8.1000405@nvidia.com>
References: <1346230800-3167-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <503DDEA8.1000405@nvidia.com>
Message-ID: <20120829094957.GF28643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 02:49:36PM +0530, Laxman Dewangan wrote:
> On Wednesday 29 August 2012 02:30 PM, Uwe Kleine-K?nig wrote:
> >Additionally DMADEVICES needs to be enabled as TEGRA20_APB_DMA depends
> >on that.
> >
> >Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> >---
> >  arch/arm/configs/tegra_defconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> >index db22453..0d6bb73 100644
> >--- a/arch/arm/configs/tegra_defconfig
> >+++ b/arch/arm/configs/tegra_defconfig
> >@@ -145,6 +145,8 @@ CONFIG_MMC_SDHCI_TEGRA=y
> >  CONFIG_RTC_CLASS=y
> >  CONFIG_RTC_DRV_EM3027=y
> >  CONFIG_RTC_DRV_TEGRA=y
> >+CONFIG_DMADEVICES=y
> >+CONFIG_TEGRA20_APB_DMA=y
> >  CONFIG_STAGING=y
> >  CONFIG_SENSORS_ISL29018=y
> >  CONFIG_SENSORS_ISL29028=y
> 
> Hi Uwe,
> Tegra team is working on to enable the new dma drivr which is
> dmaengine based. We have dma legacy driver as of now in mach-tegra.
> Some of the tests are failing with new dmadriver and so we are not
> able to enable it.
So it depends on what you wanna do with the defconfig. There are two
purposes for them:

 a) compile coverage
 b) starting point for machine support

So it all depends on what you consider to be more important.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
