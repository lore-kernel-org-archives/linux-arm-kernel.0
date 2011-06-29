From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:32 -0700
Subject: [PATCH 7/9] ARM: mxm8x10: fix nand platform data
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-8-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since two chip select is supported, the original defined nand platform
data need to be fixed accordingly.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-pxa/mxm8x10.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

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
-- 
1.7.0.4
