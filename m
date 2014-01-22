From: naresh.bhat@linaro.org (naresh.bhat at linaro.org)
Date: Wed, 22 Jan 2014 18:14:03 +0530
Subject: [PATCH] watchdog: Add sp805_wdt depends on ARM64
Message-ID: <1390394643-25443-1-git-send-email-naresh.bhat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naresh Bhat <naresh.bhat@linaro.org>

Add sp805_wdt depends on ARM64.

Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..2385124 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -109,7 +109,7 @@ config WM8350_WATCHDOG
 
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
-	depends on ARM && ARM_AMBA
+	depends on (ARM || ARM64) && ARM_AMBA
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
-- 
1.7.9.5
