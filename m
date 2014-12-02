From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 02 Dec 2014 12:04:32 +0530
Subject: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency for
 samsung
Message-ID: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As samsung thermal support is enabled only for ARCH_EXYNOS, there is no
need to select ARCH_HAS_BANDGAP from the arch-specific code. Removing this
dependency will also allow the driver to be enabled on 64-bit SoCs.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This was based on the discussion regarding adding ARCH_HAS_BANDGAP symbol for
arm64 here: http://www.spinics.net/lists/arm-kernel/msg377560.html

 drivers/thermal/samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f760389..c43306e 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Exynos thermal management unit driver"
-	depends on ARCH_HAS_BANDGAP && OF
+	depends on OF
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
-- 
1.7.9.5
