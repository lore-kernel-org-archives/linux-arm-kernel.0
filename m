From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:37:00 +0000
Subject: [PATCH] ARM: SAMSUNG: Move gpio-config.c into plat-samsung
In-Reply-To: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
References: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262918223-26529-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm/plat-s3c/gpio-config.c file is common to pretty much all the Samsung
SoCs, so move it to arch/arm/plat-samsung

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Kconfig                         |   33 -------------------
 arch/arm/plat-s3c/Makefile                        |    1 -
 arch/arm/plat-samsung/Kconfig                     |   35 +++++++++++++++++++++
 arch/arm/plat-samsung/Makefile                    |    1 +
 arch/arm/{plat-s3c => plat-samsung}/gpio-config.c |    0
 5 files changed, 36 insertions(+), 34 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/gpio-config.c (100%)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index cd979b1..454cc39 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -130,39 +130,6 @@ config S3C_GPIO_TRACK
 	  Internal configuration option to enable the s3c specific gpio
 	  chip tracking if the platform requires it.
 
-config S3C_GPIO_PULL_UPDOWN
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
-config S3C_GPIO_PULL_DOWN
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
-config S3C_GPIO_PULL_UP
-	bool
-	help
-	  Internal configuration to enable the correct GPIO pull helper
-
-config S3C_GPIO_CFG_S3C24XX
-	bool
-	help
-	  Internal configuration to enable S3C24XX style GPIO configuration
-	  functions.
-
-config S3C_GPIO_CFG_S3C64XX
-	bool
-	help
-	  Internal configuration to enable S3C64XX style GPIO configuration
-	  functions.
-
-config S5P_GPIO_CFG_S5PC1XX
-	bool
-	help
-	  Internal configuration to enable S5PC1XX style GPIO configuration
-	  functions.
-
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index d862995..ea4a001 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -14,7 +14,6 @@ obj-				:=
 obj-y				+= init.o
 obj-y				+= time.o
 obj-y				+= gpio.o
-obj-y				+= gpio-config.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 5a72a52..9e7daf2 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -19,6 +19,41 @@ config SAMSUNG_CLKSRC
 	  Select the clock code for the clksrc implementation
 	  used by newer systems such as the S3C64XX.
 
+# options for gpio configuration support
+
+config S3C_GPIO_CFG_S3C24XX
+	bool
+	help
+	  Internal configuration to enable S3C24XX style GPIO configuration
+	  functions.
+
+config S3C_GPIO_CFG_S3C64XX
+	bool
+	help
+	  Internal configuration to enable S3C64XX style GPIO configuration
+	  functions.
+
+config S5P_GPIO_CFG_S5PC1XX
+	bool
+	help
+	  Internal configuration to enable S5PC1XX style GPIO configuration
+	  functions.
+
+config S3C_GPIO_PULL_UPDOWN
+	bool
+	help
+	  Internal configuration to enable the correct GPIO pull helper
+
+config S3C_GPIO_PULL_DOWN
+	bool
+	help
+	  Internal configuration to enable the correct GPIO pull helper
+
+config S3C_GPIO_PULL_UP
+	bool
+	help
+	  Internal configuration to enable the correct GPIO pull helper
+
 # device definitions to compile in
 
 config S3C_DEV_HSMMC
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 32f03e5..2c01437 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
+obj-y				+= gpio-config.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
diff --git a/arch/arm/plat-s3c/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
similarity index 100%
rename from arch/arm/plat-s3c/gpio-config.c
rename to arch/arm/plat-samsung/gpio-config.c
-- 
1.6.0.4
