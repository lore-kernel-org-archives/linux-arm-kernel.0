From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 18:54:20 +0200
Subject: [PATCH 2/2] MMC: remove EXPERIMENTAL from the DMA selection of
	atmel-mci
In-Reply-To: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
References: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
Message-ID: <580de99c35694febc25e516ead3e3bdd9e041dfa.1309366360.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been used for years with this option enabled.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/Kconfig |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 56dbf3f..d459948 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -281,13 +281,12 @@ config MMC_ATMELMCI
 endchoice
 
 config MMC_ATMELMCI_DMA
-	bool "Atmel MCI DMA support (EXPERIMENTAL)"
-	depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE && EXPERIMENTAL
+	bool "Atmel MCI DMA support"
+	depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE
 	help
 	  Say Y here to have the Atmel MCI driver use a DMA engine to
 	  do data transfers and thus increase the throughput and
-	  reduce the CPU utilization. Note that this is highly
-	  experimental and may cause the driver to lock up.
+	  reduce the CPU utilization.
 
 	  If unsure, say N.
 
-- 
1.7.3
