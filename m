From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:54 +0200
Subject: [PATCH v2 08/10] reset: sunxi: add driver Kconfig option
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-8-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Force-enable RESET_SUNXI if ARCH_SUNXI is enabled, since the platform
   code calls our init functions.
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index afcbb99..7f748af 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -60,6 +60,12 @@ config RESET_STM32
 	help
 	  This enables the RCC reset controller driver for STM32 MCUs.
 
+config RESET_SUNXI
+	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
+	default ARCH_SUNXI
+	help
+	  This enables the reset driver for Allwinner SoCs.
+
 config TI_SYSCON_RESET
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 6276f82..4a163c7 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,4 @@
 obj-y += core.o
-obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
@@ -11,5 +10,6 @@ obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
+obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
