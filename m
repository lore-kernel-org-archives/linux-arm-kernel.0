From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 11:43:18 +0100
Subject: [PATCH] dma i.MX: remove individual SOC dependency
Message-ID: <1321958598-27260-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The individual SoC dependency in Kconfig hardly scales anymore.
Instead of having such a fine grained dependency just depend
on ARCH_MXC and risk that the uninformed user has to look in
the help text to figure out which driver is the correct one.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ab8f469..e514c45 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -124,7 +124,7 @@ config MV_XOR
 
 config MX3_IPU
 	bool "MX3x Image Processing Unit support"
-	depends on ARCH_MX3
+	depends on ARCH_MXC
 	select DMA_ENGINE
 	default y
 	help
@@ -216,11 +216,11 @@ config PCH_DMA
 
 config IMX_SDMA
 	tristate "i.MX SDMA support"
-	depends on ARCH_MX25 || ARCH_MX3 || ARCH_MX5
+	depends on ARCH_MXC
 	select DMA_ENGINE
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
-	  Freescale i.MX25/31/35/51 chips.
+	  Freescale i.MX25/31/35/51/53 chips.
 
 config IMX_DMA
 	tristate "i.MX DMA support"
-- 
1.7.7.1
