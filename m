From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 18 Nov 2012 14:56:40 +0400
Subject: [PATCH v2] Misc: ARM_CHAR_LCD: Permit the use of a driver on any ARM
 machine
Message-ID: <1353236200-11435-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-charlcd driver can be used on any ARM machine, so dependency of
PLAT_VERSATILE is removed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/misc/Kconfig |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b151b7c..ac67ce5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -434,13 +434,14 @@ config VMWARE_BALLOON
 
 config ARM_CHARLCD
 	bool "ARM Ltd. Character LCD Driver"
-	depends on PLAT_VERSATILE
-	help
-	  This is a driver for the character LCD found on the ARM Ltd.
-	  Versatile and RealView Platform Baseboards. It doesn't do
-	  very much more than display the text "ARM Linux" on the first
-	  line and the Linux version on the second line, but that's
-	  still useful.
+	depends on ARM
+	help
+	  This is a driver for the on-board character LCD found on some
+	  ARM reference boards, for example on Versatile or RealView Platform
+	  Baseboards. This is basically an Hitachi HD44780 LCD.
+	  Driver doesn't do very much more than display the text "ARM Linux"
+	  on the first line and the Linux version on the second line, but
+	  that's still useful.
 
 config BMP085
 	bool
-- 
1.7.8.6
