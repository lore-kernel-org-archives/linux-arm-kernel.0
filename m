From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:52 +0200
Subject: [PATCH v2 06/10] reset: socfpga: add driver Kconfig option
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Use "SoCFPGA" instead of "Soc FPGA".
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 8bb1d87..fc0947f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -48,6 +48,12 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_SOCFPGA
+	bool "SoCFPGA Reset Driver" if COMPILE_TEST
+	default ARCH_SOCFPGA
+	help
+	  This enables the reset controller driver for Altera SoCFPGAs.
+
 config TI_SYSCON_RESET
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index c796a14..61e4c64 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,4 @@
 obj-y += core.o
-obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
@@ -11,5 +10,6 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
