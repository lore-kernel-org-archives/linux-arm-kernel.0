From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 28 Aug 2014 13:32:00 +0530
Subject: [PATCH 5/5] phy: exynos5-usbdrd: Adding Kconfig dependency for Exynos7
In-Reply-To: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1409212920-28526-6-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This USB 3.0 PHY controller is also present on Exynos7
platform, so adding the dependency on ARCH_EXYNOS7 for this driver.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/phy/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 0dd7427..c3bc380 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -186,7 +186,7 @@ config PHY_EXYNOS5250_USB2
 
 config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
-	depends on ARCH_EXYNOS5 && OF
+	depends on (ARCH_EXYNOS5 || ARCH_EXYNOS7) && OF
 	depends on HAS_IOMEM
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
-- 
1.7.10.4
