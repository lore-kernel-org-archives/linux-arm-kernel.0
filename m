From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 15:28:59 +0200
Subject: [PATCH 07/10] reset: stm32: add driver Kconfig option
In-Reply-To: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472045342-7434-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 354e281..3a54a66 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -55,6 +55,12 @@ config RESET_SOCFPGA
 	help
 	  This enables the reset driver for Altera SoC FPGAs.
 
+config RESET_STM32
+	bool "STM32 Reset Driver" if COMPILE_TEST
+	default ARCH_STM32
+	help
+	  This enables the RCC reset controller driver for STM32 MCUs.
+
 config TI_SYSCON_RESET
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 61e4c64..6276f82 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,4 @@
 obj-y += core.o
-obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
@@ -11,5 +10,6 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
+obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
