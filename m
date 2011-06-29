From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:28 -0700
Subject: [PATCH 3/9] ARM: aspenite: fix nand platform data
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-4-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since two chip select is supported, the original defined nand platform
data need to be fixed accordingly.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

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
-- 
1.7.0.4
