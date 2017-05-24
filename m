From: s-anna@ti.com (Suman Anna)
Date: Tue, 23 May 2017 22:00:12 -0500
Subject: [PATCH] reset: ti_syscon: Rename TI_SYSCON_RESET to RESET_TI_SYSCON
Message-ID: <20170524030012.54653-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the current Kconfig name used for the TI SYSCON Reset
driver from TI_SYSCON_RESET to RESET_TI_SYSCON to match the
convention used for all the reset drivers present at the
base reset folder.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/reset/Kconfig  | 2 +-
 drivers/reset/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d21c07ccc94e..42d5631c6da0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -80,7 +80,7 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
-config TI_SYSCON_RESET
+config RESET_TI_SYSCON
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
 	select MFD_SYSCON
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 02a74db94339..26270e0f8342 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
-obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
+obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
-- 
2.12.0
