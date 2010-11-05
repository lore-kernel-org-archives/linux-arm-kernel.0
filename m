From: mspang@csclub.uwaterloo.ca (Michael Spang)
Date: Fri,  5 Nov 2010 13:14:40 -0400
Subject: [PATCH] TS-78xxx NAND resource type should be IORESOURCE_MEM
Message-ID: <1288977280-5674-1-git-send-email-mspang@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The type was IORESOURCE_IO which is not what is expected by
plat_nand_probe(). This device has not worked since 2d098a72
("mtd: plat_nand: request memory resource before doing ioremap").

Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 16f1bd5..c1c1cd0 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -239,7 +239,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 static struct resource ts78xx_ts_nand_resources = {
 	.start		= TS_NAND_DATA,
 	.end		= TS_NAND_DATA + 4,
-	.flags		= IORESOURCE_IO,
+	.flags		= IORESOURCE_MEM,
 };
 
 static struct platform_device ts78xx_ts_nand_device = {
-- 
1.7.1
