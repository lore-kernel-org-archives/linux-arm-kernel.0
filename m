From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:08 +0100
Subject: [PATCH 7/8] ARM: SAMSUNG: Documentation: add documentation on GPIO
	code
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some documentation in Documentation/arm/Samsung for the GPIO code
and where to look for the necessary functions. Update the S3C24XX case
as well.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung-S3C24XX/GPIO.txt     |    2 +
 Documentation/arm/Samsung-S3C24XX/Overview.txt |    4 ++
 Documentation/arm/Samsung/GPIO.txt             |   42 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/Samsung/GPIO.txt

diff --git a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
index 228ecb6..816d607 100644
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
@@ -12,6 +12,8 @@ Introduction
   of the s3c2410 GPIO system, please read the Samsung provided
   data-sheet/users manual to find out the complete list.
 
+  See Documentation/arm/Samsung/GPIO.txt for the core implemetation.
+
 
 GPIOLIB
 -------
diff --git a/Documentation/arm/Samsung-S3C24XX/Overview.txt b/Documentation/arm/Samsung-S3C24XX/Overview.txt
index 0f11fcc..c12bfc1 100644
--- a/Documentation/arm/Samsung-S3C24XX/Overview.txt
+++ b/Documentation/arm/Samsung-S3C24XX/Overview.txt
@@ -218,6 +218,10 @@ GPIO
   As of v2.6.34, the move towards using gpiolib support is almost
   complete, and very little of the old calls are left.
 
+  See Documentation/arm/Samsung-S3C24XX/GPIO.txt for the S3C24XX specific
+  support and Documentation/arm/Samsung/GPIO.txt for the core Samsung
+  implementation.
+
 
 Clock Management
 ----------------
diff --git a/Documentation/arm/Samsung/GPIO.txt b/Documentation/arm/Samsung/GPIO.txt
new file mode 100644
index 0000000..05850c6
--- /dev/null
+++ b/Documentation/arm/Samsung/GPIO.txt
@@ -0,0 +1,42 @@
+		Samsung GPIO implementation
+		===========================
+
+Introduction
+------------
+
+This outlines the Samsung GPIO implementation and the architecture
+specfic calls provided alongisde the drivers/gpio core.
+
+
+S3C24XX (Legacy)
+----------------
+
+See Documentation/arm/Samsung-S3C24XX/GPIO.txt for more information
+about these devices. Their implementation is being brought into line
+with the core samsung implementation described in this document.
+
+
+GPIOLIB integration
+-------------------
+
+The gpio implementation uses gpiolib as much as possible, only providing
+specific calls for the items that require Samsung specific handling, such
+as pin special-function or pull resistor control.
+
+GPIO numbering is synchronised between the Samsung and gpiolib system.
+
+
+PIN configuration
+-----------------
+
+Pin configuration is specific to the Samsung architecutre, with each SoC
+registering the necessary information for the core gpio configuration
+implementation to configure pins as necessary.
+
+The s3c_gpio_cfgpin() and s3c_gpio_setpull() provide the means for a
+driver or machine to change gpio configuration.
+
+See arch/arm/plat-samsung/include/plat/gpio-cfg.h for more information
+on these functions.
+
+
-- 
1.6.3.3
