From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 10:47:37 +0100
Subject: [PATCH] phy: miphy365x: Select GENERIC_PHY instead of depending on it
Message-ID: <1406022457-9350-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling GENERIC_PHY in the shared (by most ARM sub-architectures)
defconfig multi_v7_defconfig is prohibited.  Instead, we'll enable
it from the Kconfig whenever PHY_MIPHY365X is enabled.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5d54dcf..75cb9bc 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -34,9 +34,9 @@ config PHY_MVEBU_SATA
 config PHY_MIPHY365X
 	tristate "STMicroelectronics MIPHY365X PHY driver for STiH41x series"
 	depends on ARCH_STI
-	depends on GENERIC_PHY
 	depends on HAS_IOMEM
 	depends on OF
+	select GENERIC_PHY
 	help
 	  Enable this to support the miphy transceiver (for SATA/PCIE)
 	  that is part of STMicroelectronics STiH41x SoC series.
-- 
1.8.3.2
