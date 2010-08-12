From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 12 Aug 2010 03:14:54 +0200
Subject: [PATCH] ARM: Fix gen_nand probe structures contents
Message-ID: <1281575694-17551-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three platforms didn't properly fill nr_chips in gen_nand registration and
therefore depended on gen_nand bug fixed by the following patch:

"mtd: gen_nand: fix support for multiple chips"

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-ixp4xx/ixdp425-setup.c |    1 +
 arch/arm/mach-mx3/mach-qong.c        |    1 +
 arch/arm/mach-orion5x/ts78xx-setup.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 827cbc4..ea9ee4e 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -100,6 +100,7 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static struct platform_nand_data ixdp425_flash_nand_data = {
 	.chip = {
+		.nr_chips		= 1,
 		.chip_delay		= 30,
 		.options		= NAND_NO_AUTOINCR,
 #ifdef CONFIG_MTD_PARTITIONS
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index e5b5b83..1f9363f 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -169,6 +169,7 @@ static void qong_nand_select_chip(struct mtd_info *mtd, int chip)
 
 static struct platform_nand_data qong_nand_data = {
 	.chip = {
+		.nr_chips		= 1,
 		.chip_delay		= 20,
 		.options		= 0,
 	},
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5041d1b..696b1a9 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -216,6 +216,7 @@ static struct mtd_partition ts78xx_ts_nand_parts[] = {
 
 static struct platform_nand_data ts78xx_ts_nand_data = {
 	.chip	= {
+		.nr_chips		= 1,
 		.part_probe_types	= ts_nand_part_probes,
 		.partitions		= ts78xx_ts_nand_parts,
 		.nr_partitions		= ARRAY_SIZE(ts78xx_ts_nand_parts),
-- 
1.7.1
