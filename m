From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:50 +0200
Subject: [PATCH v2 04/10] reset: meson: add driver Kconfig option
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 72c9b78..3fa6afe 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -33,6 +33,12 @@ config RESET_LPC18XX
 	help
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
+config RESET_MESON
+	bool "Meson Reset Driver" if COMPILE_TEST
+	default ARCH_MESON
+	help
+	  This enables the reset driver for Amlogic Meson SoCs.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 25aa05a..1408cba 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,7 +1,6 @@
 obj-y += core.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
-obj-$(CONFIG_ARCH_MESON) += reset-meson.o
 obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
@@ -10,6 +9,7 @@ obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
+obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
