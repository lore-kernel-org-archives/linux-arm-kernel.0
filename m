From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:29 -0700
Subject: [PATCH 4/9] ARM: cm-x300: fix nand platform data
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-5-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since two chip select is supported, the original defined nand platform
data need to be fixed accordingly.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-pxa/cm-x300.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

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
-- 
1.7.0.4
