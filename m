From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 20:51:28 +0200
Subject: [PATCH] phy: sun4i: depend on RESET_CONTROLLER
Message-ID: <1400871088-16894-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver depend on the reset framework in a mandatory way. Make sure
reset_control_get is defined by adding this dependency in Kconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 16a2f067c242..1d8099a56a91 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -112,6 +112,7 @@ config PHY_EXYNOS5250_SATA
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
 	select GENERIC_PHY
 	help
 	  Enable this to support the transceiver that is part of Allwinner
-- 
1.9.3
