From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:49 +0200
Subject: [PATCH v2 03/10] reset: lpc18xx: add driver Kconfig option
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Acked-by: Joachim Eastwood <manabian@gmail.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Fixed Kconfig option help text
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1194cbe..72c9b78 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -27,6 +27,12 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
+config RESET_LPC18XX
+	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
+	default ARCH_LPC18XX
+	help
+	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 34c0b23..25aa05a 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,4 @@
 obj-y += core.o
-obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_ARCH_MESON) += reset-meson.o
@@ -10,6 +9,7 @@ obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
