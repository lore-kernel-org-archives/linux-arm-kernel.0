From: laforge@gnumonks.org (laforge at gnumonks.org)
Date: Wed,  9 Sep 2009 20:06:16 +0900
Subject: [PATCH 2/3] watchdog: Samsung SoC Watchdog is not s3c24xx specific
Message-ID: <1252494376-7333-1-git-send-email-laforge@gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

Kconfig change to make sure we can build the watchdog driver
on s3c64xx based machines.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 drivers/watchdog/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b1ccc04..c6cf548 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -139,10 +139,10 @@ config KS8695_WATCHDOG
 	  system when the timeout is reached.
 
 config S3C2410_WATCHDOG
-	tristate "S3C2410 Watchdog"
-	depends on ARCH_S3C2410
+	tristate "Samsung SoC Watchdog"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
 	help
-	  Watchdog timer block in the Samsung S3C2410 chips. This will
+	  Watchdog timer block in the Samsung SoC chips. This will
 	  reboot the system when the timer expires with the watchdog
 	  enabled.
 
-- 
1.5.3.4
