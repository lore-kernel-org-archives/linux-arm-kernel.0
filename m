From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:47 +0200
Subject: [PATCH v2 01/10] reset: ath79: add driver Kconfig option
Message-ID: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visible only if COMPILE_TEST is enabled, this allows to include the
driver in build tests.

Acked-by: Aban Bedel <albeu@free.fr>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 7 +++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7dfe8d8..9da0507 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -14,6 +14,13 @@ menuconfig RESET_CONTROLLER
 
 if RESET_CONTROLLER
 
+config RESET_ATH79
+	bool "AR71xx Reset Driver" if COMPILE_TEST
+	default ATH79
+	help
+	  This enables the ATH79 reset controller driver that supports the
+	  AR71xx SoC reset controller.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 9b45dcf..e3fc337 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
-obj-$(CONFIG_ATH79) += reset-ath79.o
+obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-- 
2.8.1
