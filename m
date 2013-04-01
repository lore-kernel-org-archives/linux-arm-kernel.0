From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 20:10:33 +0800
Subject: [PATCH] reset: make it depend on CONFIG_OF
Message-ID: <1364818233-24102-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset API is really designed for device tree users, so make it
depend on CONFIG_OF to fix the compile warning below seen with i386
allyesconfig.

 drivers/reset/gpio-reset.c:187:28: warning: 'gpio_reset_dt_ids' defined but not used [-Wunused-variable]

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/reset/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index e728d36..324a2b3 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -4,6 +4,7 @@ config ARCH_HAS_RESET_CONTROLLER
 menuconfig RESET_CONTROLLER
 	bool "Reset Controller Support"
 	default y if ARCH_HAS_RESET_CONTROLLER
+	depends on OF
 	help
 	  Generic Reset Controller support.
 
-- 
1.7.9.5
