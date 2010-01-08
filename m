From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:36:59 +0000
Subject: [PATCH] ARM: SAMSUNG: Move device definitions in plat-samsung
In-Reply-To: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
References: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262918223-26529-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all the platform device definitions from plat-s3c into plat-samsung

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Kconfig                          |   42 --------------------
 arch/arm/plat-s3c/Makefile                         |   12 ------
 arch/arm/plat-samsung/Kconfig                      |   42 ++++++++++++++++++++
 arch/arm/plat-samsung/Makefile                     |   12 ++++++
 arch/arm/{plat-s3c => plat-samsung}/dev-fb.c       |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc.c    |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc1.c   |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc2.c   |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-i2c0.c     |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-i2c1.c     |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-nand.c     |    0
 .../arm/{plat-s3c => plat-samsung}/dev-usb-hsotg.c |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-usb.c      |    0
 13 files changed, 54 insertions(+), 54 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-fb.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc1.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc2.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-i2c0.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-i2c1.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-nand.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-usb-hsotg.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-usb.c (100%)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 9e9d028..cd979b1 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -170,46 +170,4 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core
 
-# device definitions to compile in
-
-config S3C_DEV_HSMMC
-	bool
-	help
-	  Compile in platform device definitions for HSMMC code
-
-config S3C_DEV_HSMMC1
-	bool
-	help
-	  Compile in platform device definitions for HSMMC channel 1
-
-config S3C_DEV_HSMMC2
-	bool
-	help
-	  Compile in platform device definitions for HSMMC channel 2
-
-config S3C_DEV_I2C1
-	bool
-	help
-	  Compile in platform device definitions for I2C channel 1
-
-config S3C_DEV_FB
-	bool
-	help
-	  Compile in platform device definition for framebuffer
-
-config S3C_DEV_USB_HOST
-	bool
-	help
-	  Compile in platform device definition for USB host.
-
-config S3C_DEV_USB_HSOTG
-	bool
-	help
-	  Compile in platform device definition for USB high-speed OtG
-
-config S3C_DEV_NAND
-	bool
-	help
-	  Compile in platform device definition for NAND controller
-
 endif
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index ef10a91..d862995 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -29,15 +29,3 @@ obj-$(CONFIG_S3C2410_PM_CHECK)	+= pm-check.o
 # PWM support
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
-
-# devices
-
-obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
-obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
-obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
-obj-y				+= dev-i2c0.o
-obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
-obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
-obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
-obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
-obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index e3ae684..5a72a52 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -19,4 +19,46 @@ config SAMSUNG_CLKSRC
 	  Select the clock code for the clksrc implementation
 	  used by newer systems such as the S3C64XX.
 
+# device definitions to compile in
+
+config S3C_DEV_HSMMC
+	bool
+	help
+	  Compile in platform device definitions for HSMMC code
+
+config S3C_DEV_HSMMC1
+	bool
+	help
+	  Compile in platform device definitions for HSMMC channel 1
+
+config S3C_DEV_HSMMC2
+	bool
+	help
+	  Compile in platform device definitions for HSMMC channel 2
+
+config S3C_DEV_I2C1
+	bool
+	help
+	  Compile in platform device definitions for I2C channel 1
+
+config S3C_DEV_FB
+	bool
+	help
+	  Compile in platform device definition for framebuffer
+
+config S3C_DEV_USB_HOST
+	bool
+	help
+	  Compile in platform device definition for USB host.
+
+config S3C_DEV_USB_HSOTG
+	bool
+	help
+	  Compile in platform device definition for USB high-speed OtG
+
+config S3C_DEV_NAND
+	bool
+	help
+	  Compile in platform device definition for NAND controller
+
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index d4d5f94..32f03e5 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -15,3 +15,15 @@ obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
+
+# devices
+
+obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
+obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
+obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
+obj-y				+= dev-i2c0.o
+obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
+obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
+obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
+obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
+obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
diff --git a/arch/arm/plat-s3c/dev-fb.c b/arch/arm/plat-samsung/dev-fb.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-fb.c
rename to arch/arm/plat-samsung/dev-fb.c
diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-hsmmc.c
rename to arch/arm/plat-samsung/dev-hsmmc.c
diff --git a/arch/arm/plat-s3c/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-hsmmc1.c
rename to arch/arm/plat-samsung/dev-hsmmc1.c
diff --git a/arch/arm/plat-s3c/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-hsmmc2.c
rename to arch/arm/plat-samsung/dev-hsmmc2.c
diff --git a/arch/arm/plat-s3c/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-i2c0.c
rename to arch/arm/plat-samsung/dev-i2c0.c
diff --git a/arch/arm/plat-s3c/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-i2c1.c
rename to arch/arm/plat-samsung/dev-i2c1.c
diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-samsung/dev-nand.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-nand.c
rename to arch/arm/plat-samsung/dev-nand.c
diff --git a/arch/arm/plat-s3c/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-usb-hsotg.c
rename to arch/arm/plat-samsung/dev-usb-hsotg.c
diff --git a/arch/arm/plat-s3c/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
similarity index 100%
rename from arch/arm/plat-s3c/dev-usb.c
rename to arch/arm/plat-samsung/dev-usb.c
-- 
1.6.0.4
