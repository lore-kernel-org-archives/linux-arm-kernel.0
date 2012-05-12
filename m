From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 12 May 2012 13:37:05 +0100
Subject: [PATCH 2/4 V2] ARM: orion5x: ts78xx fix NAND resource off by one
In-Reply-To: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
References: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1336826227-17020-3-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
 v2: use DEFINE_RES_MEM as suggesed by Hartley Sweeten
 v1: inital release

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c41f27b..d8670cb 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -292,11 +292,8 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 	},
 };
 
-static struct resource ts78xx_ts_nand_resources = {
-	.start		= TS_NAND_DATA,
-	.end		= TS_NAND_DATA + 4,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource ts78xx_ts_nand_resources
+			= DEFINE_RES_MEM(TS_NAND_DATA, 4);
 
 static struct platform_device ts78xx_ts_nand_device = {
 	.name		= "gen_nand",
@@ -332,11 +329,8 @@ static void ts78xx_ts_nand_unload(void)
  ****************************************************************************/
 #define TS_RNG_DATA	(TS78XX_FPGA_REGS_PHYS_BASE | 0x044)
 
-static struct resource ts78xx_ts_rng_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= TS_RNG_DATA,
-	.end		= TS_RNG_DATA + 4 - 1,
-};
+static struct resource ts78xx_ts_rng_resource
+			= DEFINE_RES_MEM(TS_RNG_DATA, 4);
 
 static struct timeriomem_rng_data ts78xx_ts_rng_data = {
 	.period		= 1000000, /* one second */
-- 
1.7.10
