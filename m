From: leiwen@marvell.com (Lei Wen)
Date: Mon,  4 Jul 2011 02:25:36 -0700
Subject: [PATCH 4/4] ARM: mmp/pxa: fix nand platform data
In-Reply-To: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
Message-ID: <1309771536-10597-5-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since two chip select is supported, the original defined nand platform
data need to be fixed accordingly.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c       |    5 +++--
 arch/arm/mach-pxa/cm-x300.c        |    5 +++--
 arch/arm/mach-pxa/colibri-pxa3xx.c |    5 +++--
 arch/arm/mach-pxa/littleton.c      |    5 +++--
 arch/arm/mach-pxa/mxm8x10.c        |    9 +++++----
 arch/arm/mach-pxa/raumfeld.c       |    5 +++--
 arch/arm/mach-pxa/zylonite.c       |    5 +++--
 7 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..c4996f3 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -167,8 +167,9 @@ static struct mtd_partition aspenite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= aspenite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
+	.num_cs = 1,
+	.parts[0]	= aspenite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
 };
 
 static struct i2c_board_info aspenite_i2c_info[] __initdata = {
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index b2248e7..969d252 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -423,8 +423,9 @@ static struct mtd_partition cm_x300_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data cm_x300_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= cm_x300_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(cm_x300_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= cm_x300_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(cm_x300_nand_partitions),
 };
 
 static void __init cm_x300_init_nand(void)
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 3f9be41..2b8ca0d 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -139,8 +139,9 @@ static struct mtd_partition colibri_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data colibri_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= colibri_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(colibri_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= colibri_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(colibri_nand_partitions),
 };
 
 void __init colibri_pxa3xx_init_nand(void)
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index e5e326d..f6d1f9d 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -325,8 +325,9 @@ static struct mtd_partition littleton_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data littleton_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= littleton_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(littleton_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= littleton_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(littleton_nand_partitions),
 };
 
 static void __init littleton_init_nand(void)
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index b5a8fd3..90928d6 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -389,10 +389,11 @@ static struct mtd_partition mxm_8x10_nand_partitions[] = {
 };
 
 static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
-	.enable_arbiter = 1,
-	.keep_config = 1,
-	.parts = mxm_8x10_nand_partitions,
-	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions)
+	.enable_arbiter	= 1,
+	.keep_config	= 1,
+	.num_cs		= 1,
+	.parts[0]	= mxm_8x10_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(mxm_8x10_nand_partitions)
 };
 
 static void __init mxm_8x10_nand_init(void)
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d130f77..c7ec847 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -349,8 +349,9 @@ static struct mtd_partition raumfeld_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= raumfeld_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(raumfeld_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= raumfeld_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(raumfeld_nand_partitions),
 };
 
 /**
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 5821185..64fdac9 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -366,8 +366,9 @@ static struct mtd_partition zylonite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= zylonite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= zylonite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(zylonite_nand_partitions),
 };
 
 static void __init zylonite_init_nand(void)
-- 
1.7.0.4
