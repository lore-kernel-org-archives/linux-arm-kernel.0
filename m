From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 12 Aug 2017 11:10:41 +0530
Subject: [PATCH 1/3] bus: kconfig: Enable SUNXI RSB for arm64
Message-ID: <1502516443-4740-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Sunxi arm64 doesn't have separate configs for
h5 and a64 so enable SUNXI_RSB bus for ARM64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 2408ea3..ae3d8f3 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -132,7 +132,7 @@ config SIMPLE_PM_BUS
 
 config SUNXI_RSB
 	tristate "Allwinner sunXi Reduced Serial Bus Driver"
-	  default MACH_SUN8I || MACH_SUN9I
+	  default MACH_SUN8I || MACH_SUN9I || ARM64
 	  depends on ARCH_SUNXI
 	  select REGMAP
 	  help
-- 
2.7.4
