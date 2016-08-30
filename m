From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:51 +0200
Subject: [PATCH v2 05/10] reset: pistachio: add driver Kconfig option
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Cc: Damien Horsley <Damien.Horsley@imgtec.com>
Acked-by: James Hartley <james.hartley@imgtec.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3fa6afe..8bb1d87 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -42,6 +42,12 @@ config RESET_MESON
 config RESET_OXNAS
 	bool
 
+config RESET_PISTACHIO
+	bool "Pistachio Reset Driver" if COMPILE_TEST
+	default MACH_PISTACHIO
+	help
+	  This enables the reset driver for ImgTec Pistachio SoCs.
+
 config TI_SYSCON_RESET
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 1408cba..c796a14 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,5 @@
 obj-y += core.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
@@ -11,5 +10,6 @@ obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
+obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
