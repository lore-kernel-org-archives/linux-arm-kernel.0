From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 May 2010 14:28:00 -0700
Subject: [PATCH 05/10] OMAP4: SPI: Fix Driver Kconfig
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Message-ID: <20100514212800.25599.65298.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Change dependency to ARCH_OMAP2PLUS to allow systems based on
omap24xx, omap34xx or omap44xx

Cc: spi-devel-general at lists.sourceforge.net
Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/spi/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a191fa2..f950b63 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -180,10 +180,10 @@ config SPI_OMAP_UWIRE
 	  This hooks up to the MicroWire controller on OMAP1 chips.
 
 config SPI_OMAP24XX
-	tristate "McSPI driver for OMAP24xx/OMAP34xx"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	tristate "McSPI driver for OMAP"
+	depends on ARCH_OMAP2PLUS
 	help
-	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
+	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
 
 config SPI_OMAP_100K
