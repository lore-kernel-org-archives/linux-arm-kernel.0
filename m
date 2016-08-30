From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Aug 2016 10:24:56 +0200
Subject: [PATCH v2 10/10] reset: hi6220: allow to compile test driver on other
 architectures
In-Reply-To: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472545496-14373-10-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also remove the RESET_CONTROLLER dependency, this Kconfig file is
included inside the menuconfig already.

Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - To build without ARCH_HISI enabled, add hisilicon/ to obj-y
   unconditionally.
---
 drivers/reset/Makefile          | 2 +-
 drivers/reset/hisilicon/Kconfig | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 56f90ea..bbe7026 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,6 @@
 obj-y += core.o
+obj-y += hisilicon/
 obj-$(CONFIG_ARCH_STI) += sti/
-obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
diff --git a/drivers/reset/hisilicon/Kconfig b/drivers/reset/hisilicon/Kconfig
index 26bf95a..1ff8b0c 100644
--- a/drivers/reset/hisilicon/Kconfig
+++ b/drivers/reset/hisilicon/Kconfig
@@ -1,5 +1,6 @@
 config COMMON_RESET_HI6220
 	tristate "Hi6220 Reset Driver"
-	depends on (ARCH_HISI && RESET_CONTROLLER)
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 reset driver.
-- 
2.8.1
