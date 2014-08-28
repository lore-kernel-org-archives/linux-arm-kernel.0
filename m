From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 28 Aug 2014 13:31:59 +0530
Subject: [PATCH 4/5] usb: dwc3: Adding Kconfig dependency for Exynos7
In-Reply-To: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1409212920-28526-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos-DWC3 USB 3.0 DRD controller is also present on
Exynos7 platform, so adding the dependency on ARCH_EXYNOS7
for this driver.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 785510a..e235894 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -55,7 +55,7 @@ config USB_DWC3_OMAP
 
 config USB_DWC3_EXYNOS
 	tristate "Samsung Exynos Platform"
-	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on (ARCH_EXYNOS || ARCH_EXYNOS7) || COMPILE_TEST
 	default USB_DWC3
 	help
 	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
-- 
1.7.10.4
