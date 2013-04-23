From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Apr 2013 11:27:15 +0900
Subject: [PATCH] ARM: shmobile: sh73a0: Use DEFINE_RES_MEM*() everywhere
Message-ID: <1366684035-6882-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert code to use DEFINE_RES_MEM*() macros.
These macros were already used in this file,
this change makes their usage consistent throughout the file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* As suggested by Sergei Shtylyov:
  Correct change log to refer to DEFINE_RES_MEM* instead of
  IORESOURCE_MEM_*.
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 79 ++++++-----------------------------
 1 file changed, 13 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 658c0ad..2ac5f2f 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -244,12 +244,7 @@ static struct sh_timer_config tmu00_platform_data = {
 };
 
 static struct resource tmu00_resources[] = {
-	[0] = {
-		.name	= "TMU00",
-		.start	= 0xfff60008,
-		.end	= 0xfff60013,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xfff60008, 0xc, "TMU00"),
 	[1] = {
 		.start	= intcs_evt2irq(0x0e80), /* TMU0_TUNI00 */
 		.flags	= IORESOURCE_IRQ,
@@ -274,12 +269,7 @@ static struct sh_timer_config tmu01_platform_data = {
 };
 
 static struct resource tmu01_resources[] = {
-	[0] = {
-		.name	= "TMU01",
-		.start	= 0xfff60014,
-		.end	= 0xfff6001f,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xfff60014, 0xc, "TMU00"),
 	[1] = {
 		.start	= intcs_evt2irq(0x0ea0), /* TMU0_TUNI01 */
 		.flags	= IORESOURCE_IRQ,
@@ -297,12 +287,7 @@ static struct platform_device tmu01_device = {
 };
 
 static struct resource i2c0_resources[] = {
-	[0] = {
-		.name	= "IIC0",
-		.start	= 0xe6820000,
-		.end	= 0xe6820425 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xe6820000, 0x426, "IIC0"),
 	[1] = {
 		.start	= gic_spi(167),
 		.end	= gic_spi(170),
@@ -311,12 +296,7 @@ static struct resource i2c0_resources[] = {
 };
 
 static struct resource i2c1_resources[] = {
-	[0] = {
-		.name	= "IIC1",
-		.start	= 0xe6822000,
-		.end	= 0xe6822425 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xe6822000, 0x426, "IIC1"),
 	[1] = {
 		.start	= gic_spi(51),
 		.end	= gic_spi(54),
@@ -325,12 +305,7 @@ static struct resource i2c1_resources[] = {
 };
 
 static struct resource i2c2_resources[] = {
-	[0] = {
-		.name	= "IIC2",
-		.start	= 0xe6824000,
-		.end	= 0xe6824425 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xe6824000, 0x426, "IIC2"),
 	[1] = {
 		.start	= gic_spi(171),
 		.end	= gic_spi(174),
@@ -339,12 +314,7 @@ static struct resource i2c2_resources[] = {
 };
 
 static struct resource i2c3_resources[] = {
-	[0] = {
-		.name	= "IIC3",
-		.start	= 0xe6826000,
-		.end	= 0xe6826425 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xe6826000, 0x426, "IIC3"),
 	[1] = {
 		.start	= gic_spi(183),
 		.end	= gic_spi(186),
@@ -353,12 +323,7 @@ static struct resource i2c3_resources[] = {
 };
 
 static struct resource i2c4_resources[] = {
-	[0] = {
-		.name	= "IIC4",
-		.start	= 0xe6828000,
-		.end	= 0xe6828425 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(0xe6828000, 0x426, "IIC4"),
 	[1] = {
 		.start	= gic_spi(187),
 		.end	= gic_spi(190),
@@ -579,12 +544,7 @@ static struct sh_dmae_pdata sh73a0_dmae_platform_data = {
 };
 
 static struct resource sh73a0_dmae_resources[] = {
-	{
-		/* Registers including DMAOR and channels including DMARSx */
-		.start  = 0xfe000020,
-		.end    = 0xfe008a00 - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(0xfe000020, 0x89e0),
 	{
 		.name	= "error_irq",
 		.start  = gic_spi(129),
@@ -683,18 +643,10 @@ static struct sh_dmae_pdata sh73a0_mpdma_platform_data = {
 
 /* Resource order important! */
 static struct resource sh73a0_mpdma_resources[] = {
-	{
-		/* Channel registers and DMAOR */
-		.start	= 0xec618020,
-		.end	= 0xec61828f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		/* DMARSx */
-		.start	= 0xec619000,
-		.end	= 0xec61900b,
-		.flags	= IORESOURCE_MEM,
-	},
+	/* Channel registers and DMAOR */
+	DEFINE_RES_MEM(0xec618020, 0x270),
+	/* DMARSx */
+	DEFINE_RES_MEM(0xec619000, 0xc),
 	{
 		.name	= "error_irq",
 		.start	= gic_spi(181),
@@ -741,12 +693,7 @@ static struct platform_device pmu_device = {
 
 /* an IPMMU module for ICB */
 static struct resource ipmmu_resources[] = {
-	[0] = {
-		.name	= "IPMMU",
-		.start	= 0xfe951000,
-		.end	= 0xfe9510ff,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM_NAMED(0xfe951000, 0x100, "IPMMU"),
 };
 
 static const char * const ipmmu_dev_names[] = {
-- 
1.8.2.1
