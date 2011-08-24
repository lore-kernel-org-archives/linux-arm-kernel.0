From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:41:08 +0200
Subject: [PATCH 1/5] mmc i.MX: remove individual SoC dependency
In-Reply-To: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168072-13822-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The individual SoC dependency in Kconfig hardly scales anymore.
Instead of having such a fine grained dependency just depend
on ARCH_MXC and risk that the uninformed user has to look in
the help text to figure out which driver is the correct one.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc at vger.kernel.org
---
 drivers/mmc/host/Kconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c87096..c226d54 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -131,12 +131,12 @@ config MMC_SDHCI_CNS3XXX
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI platform support for the Freescale eSDHC i.MX controller"
-	depends on ARCH_MX25 || ARCH_MX35 || ARCH_MX5
+	depends on ARCH_MXC
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Freescale eSDHC controller support on the platform
-	  bus, found on platforms like mx35/51.
+	  bus, found on i.MX25, i.MX35 and i.MX5x.
 
 	  If you have a controller with this interface, say Y or M here.
 
@@ -326,11 +326,11 @@ config MMC_MSM
 	  support for SDIO devices.
 
 config MMC_MXC
-	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
-	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
+	tristate "Freescale i.MX21/27/31 Multimedia Card Interface support"
+	depends on ARCH_MXC
 	help
-	  This selects the Freescale i.MX2/3 Multimedia card Interface.
-	  If you have a i.MX platform with a Multimedia Card slot,
+	  This selects the Freescale i.MX21, i.MX27 and i.MX31 Multimedia card
+	  Interface. If you have a i.MX platform with a Multimedia Card slot,
 	  say Y or M here.
 
 	  If unsure, say N.
-- 
1.7.5.4
