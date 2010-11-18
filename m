From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 18 Nov 2010 18:20:50 +0900
Subject: [PATCH 2/9] ARM: Samsung: Rename s3c64xx I2S platform device
In-Reply-To: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
Message-ID: <1290072050-17345-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Since the I2S of S3C64XX and newer SoCs are incremental
versions of each other with changes managable in a single
driver, rename the 's3c64xx-iis' -> 'samsung-i2s'

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c |    6 +++---
 arch/arm/mach-s5p6442/dev-audio.c |    4 ++--
 arch/arm/mach-s5p64x0/dev-audio.c |    4 ++--
 arch/arm/mach-s5pc100/dev-audio.c |    6 +++---
 arch/arm/mach-s5pv210/dev-audio.c |    6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 76426a3..447e4e7 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -77,7 +77,7 @@ static struct s3c_audio_pdata s3c_i2s0_pdata = {
 };
 
 struct platform_device s3c64xx_device_iis0 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis0_resource),
 	.resource	  = s3c64xx_iis0_resource,
@@ -110,7 +110,7 @@ static struct s3c_audio_pdata s3c_i2s1_pdata = {
 };
 
 struct platform_device s3c64xx_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis1_resource),
 	.resource	  = s3c64xx_iis1_resource,
@@ -143,7 +143,7 @@ static struct s3c_audio_pdata s3c_i2sv4_pdata = {
 };
 
 struct platform_device s3c64xx_device_iisv4 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
index 3462197..d0207b7 100644
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -65,7 +65,7 @@ static struct resource s5p6442_iis0_resource[] = {
 };
 
 struct platform_device s5p6442_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis0_resource),
 	.resource	  = s5p6442_iis0_resource,
@@ -93,7 +93,7 @@ static struct resource s5p6442_iis1_resource[] = {
 };
 
 struct platform_device s5p6442_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
 	.resource	  = s5p6442_iis1_resource,
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index 396bacc..fb613d0 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -82,7 +82,7 @@ static struct resource s5p64x0_iis0_resource[] = {
 };
 
 struct platform_device s5p6440_device_iis = {
-	.name		= "s3c64xx-iis-v4",
+	.name		= "samsung-i2s-v4",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
 	.resource	= s5p64x0_iis0_resource,
@@ -92,7 +92,7 @@ struct platform_device s5p6440_device_iis = {
 };
 
 struct platform_device s5p6450_device_iis0 = {
-	.name		= "s3c64xx-iis-v4",
+	.name		= "samsung-i2s-v4",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
 	.resource	= s5p64x0_iis0_resource,
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 564e195..bf0c90f 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -65,7 +65,7 @@ static struct resource s5pc100_iis0_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis0_resource),
 	.resource	  = s5pc100_iis0_resource,
@@ -93,7 +93,7 @@ static struct resource s5pc100_iis1_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis1_resource),
 	.resource	  = s5pc100_iis1_resource,
@@ -121,7 +121,7 @@ static struct resource s5pc100_iis2_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis2 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis2_resource),
 	.resource	  = s5pc100_iis2_resource,
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 1303fcb..961477a 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -66,7 +66,7 @@ static struct resource s5pv210_iis0_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis0_resource),
 	.resource	  = s5pv210_iis0_resource,
@@ -94,7 +94,7 @@ static struct resource s5pv210_iis1_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis1_resource),
 	.resource	  = s5pv210_iis1_resource,
@@ -122,7 +122,7 @@ static struct resource s5pv210_iis2_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis2 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis2_resource),
 	.resource	  = s5pv210_iis2_resource,
-- 
1.6.2.5
