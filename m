From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 15 Oct 2018 10:31:30 +0900
Subject: [PATCH] phy: uniphier-pcie: Depend on HAS_IOMEM
Message-ID: <1539567090-10498-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses devm_ioremap_resource() which is only available when
CONFIG_HAS_IOMEM is set, so the driver depends on this option.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
index 467e814..9c85231 100644
--- a/drivers/phy/socionext/Kconfig
+++ b/drivers/phy/socionext/Kconfig
@@ -26,7 +26,8 @@ config PHY_UNIPHIER_USB3
 
 config PHY_UNIPHIER_PCIE
 	tristate "Uniphier PHY driver for PCIe controller"
-	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
 	default PCIE_UNIPHIER
 	select GENERIC_PHY
 	help
-- 
2.7.4
