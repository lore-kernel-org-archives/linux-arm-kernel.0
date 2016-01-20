From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:57:01 +0100
Subject: [PATCH 1/6] dma: enable mxs-dma for imx6ul
In-Reply-To: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453294626-17608-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs-dma unit is also available on i.MX6UL. Make it possible to
select it in Kconfig.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/dma/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 79b1390..2516524 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -341,12 +341,13 @@ config MV_XOR
 
 config MXS_DMA
 	bool "MXS DMA support"
-	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q
+	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q || SOC_MX6UL
 	select STMP_DEVICE
 	select DMA_ENGINE
 	help
 	  Support the MXS DMA engine. This engine including APBH-DMA
-	  and APBX-DMA is integrated into Freescale i.MX23/28/MX6Q/MX6DL chips.
+	  and APBX-DMA is integrated into Freescale
+	  i.MX23/28/MX6Q/MX6DL/MX6UL chips.
 
 config MX3_IPU
 	bool "MX3x Image Processing Unit support"
-- 
2.1.4
