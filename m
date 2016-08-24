From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 15:29:01 +0200
Subject: [PATCH 09/10] reset: zynq: add driver Kconfig option
In-Reply-To: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472045342-7434-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Cc: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 17030e2..86b49a2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -67,6 +67,12 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
+config RESET_ZYNQ
+	bool "ZYNQ Reset Driver" if COMPILE_TEST
+	default ARCH_ZYNQ
+	help
+	  This enables the reset driver for Xilinx Zynq FPGAs.
+
 config TI_SYSCON_RESET
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4a163c7..56f90ea 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,7 +1,6 @@
 obj-y += core.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
-obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
@@ -13,3 +12,4 @@ obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
+obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
-- 
2.8.1
