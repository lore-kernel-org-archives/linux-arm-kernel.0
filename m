From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:25 -0700
Subject: [PATCH 01/47] davinci: da850 evm: sparse cleanup: make file local
	variables static
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-2-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Without this cleanup, sparse checker reports warnings of the type:

  CHECK   arch/arm/mach-davinci/board-da850-evm.c
arch/arm/mach-davinci/board-da850-evm.c:112:22: warning: symbol 'da850_evm_nandflash_partition' was not declared. Should it be static?

The nand flash partitions and regulator supplies are used within
the EVM file and so should have been static

This patch has been boot tested on DA830 and DA850 EVMs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index fdc2cc5..711a56a 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -110,7 +110,7 @@ static struct platform_device da850_pm_device = {
  * to boot, using TI's tools to install the secondary boot loader
  * (UBL) and U-Boot.
  */
-struct mtd_partition da850_evm_nandflash_partition[] = {
+static struct mtd_partition da850_evm_nandflash_partition[] = {
 	{
 		.name		= "u-boot env",
 		.offset		= 0,
@@ -406,7 +406,7 @@ static int da850_lcd_hw_init(void)
 /* TPS65070 voltage regulator support */
 
 /* 3.3V */
-struct regulator_consumer_supply tps65070_dcdc1_consumers[] = {
+static struct regulator_consumer_supply tps65070_dcdc1_consumers[] = {
 	{
 		.supply = "usb0_vdda33",
 	},
@@ -416,7 +416,7 @@ struct regulator_consumer_supply tps65070_dcdc1_consumers[] = {
 };
 
 /* 3.3V or 1.8V */
-struct regulator_consumer_supply tps65070_dcdc2_consumers[] = {
+static struct regulator_consumer_supply tps65070_dcdc2_consumers[] = {
 	{
 		.supply = "dvdd3318_a",
 	},
@@ -429,14 +429,14 @@ struct regulator_consumer_supply tps65070_dcdc2_consumers[] = {
 };
 
 /* 1.2V */
-struct regulator_consumer_supply tps65070_dcdc3_consumers[] = {
+static struct regulator_consumer_supply tps65070_dcdc3_consumers[] = {
 	{
 		.supply = "cvdd",
 	},
 };
 
 /* 1.8V LDO */
-struct regulator_consumer_supply tps65070_ldo1_consumers[] = {
+static struct regulator_consumer_supply tps65070_ldo1_consumers[] = {
 	{
 		.supply = "sata_vddr",
 	},
@@ -452,7 +452,7 @@ struct regulator_consumer_supply tps65070_ldo1_consumers[] = {
 };
 
 /* 1.2V LDO */
-struct regulator_consumer_supply tps65070_ldo2_consumers[] = {
+static struct regulator_consumer_supply tps65070_ldo2_consumers[] = {
 	{
 		.supply = "sata_vdd",
 	},
@@ -475,7 +475,7 @@ static struct tps6507x_reg_platform_data tps6507x_platform_data = {
 	.defdcdc_default = true,
 };
 
-struct regulator_init_data tps65070_regulator_data[] = {
+static struct regulator_init_data tps65070_regulator_data[] = {
 	/* dcdc1 */
 	{
 		.constraints = {
-- 
1.7.2.1
