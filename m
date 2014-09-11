From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 11 Sep 2014 18:47:27 +0100
Subject: [PATCH] phy: miphy365x: Select GENERIC_PHY rather than depends on
Message-ID: <1410457647-14086-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change miphy365x over to select GENERIC_PHY like all other phy drivers.
Also update the help message as the new stih410 SoC doesn't have this
phy (it is very similar to sti407), so the stih41x naming is sadly no
longer correct.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d361d98..68bfe07 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -39,14 +39,14 @@ config PHY_MVEBU_SATA
 	select GENERIC_PHY
 
 config PHY_MIPHY365X
-	tristate "STMicroelectronics MIPHY365X PHY driver for STiH41x series"
+	tristate "STMicroelectronics MIPHY365X PHY driver for STiH415/6 series"
 	depends on ARCH_STI
-	depends on GENERIC_PHY
 	depends on HAS_IOMEM
 	depends on OF
+	select GENERIC_PHY
 	help
 	  Enable this to support the miphy transceiver (for SATA/PCIE)
-	  that is part of STMicroelectronics STiH41x SoC series.
+	  that is part of STMicroelectronics STiH415/6 SoC series.
 
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
-- 
1.9.1
