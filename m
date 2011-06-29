From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:33 -0700
Subject: [PATCH 8/9] ARM: raumfeld: fix nand platform data
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-9-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since two chip select is supported, the original defined nand platform
data need to be fixed accordingly.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-pxa/raumfeld.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

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
-- 
1.7.0.4
