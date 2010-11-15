From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 15 Nov 2010 14:12:05 -0500
Subject: [PATCH v5 03/12] davinci: add ssp config for tnetv107x evm board
In-Reply-To: <1289848334-8695-1-git-send-email-cyril@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
Message-ID: <1289848334-8695-4-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SSP configuration and pin muxing info for tnetv107x
evm boards.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index a6db854..ef526b1 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -99,6 +99,12 @@ static const short uart1_pins[] __initdata = {
 	-1
 };
 
+static const short ssp_pins[] __initdata = {
+	TNETV107X_SSP0_0, TNETV107X_SSP0_1, TNETV107X_SSP0_2,
+	TNETV107X_SSP1_0, TNETV107X_SSP1_1, TNETV107X_SSP1_2,
+	TNETV107X_SSP1_3, -1
+};
+
 static struct mtd_partition nand_partitions[] = {
 	/* bootloader (U-Boot, etc) in first 12 sectors */
 	{
@@ -196,17 +202,25 @@ static struct matrix_keypad_platform_data keypad_config = {
 	.no_autorepeat	= 0,
 };
 
+static struct ti_ssp_data ssp_config = {
+	.out_clock	= 250 * 1000,
+	.dev_data	= {
+	},
+};
+
 static struct tnetv107x_device_info evm_device_info __initconst = {
 	.serial_config		= &serial_config,
 	.mmc_config[1]		= &mmc_config,	/* controller 1 */
 	.nand_config[0]		= &nand_config,	/* chip select 0 */
 	.keypad_config		= &keypad_config,
+	.ssp_config		= &ssp_config,
 };
 
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
 	davinci_cfg_reg_list(uart1_pins);
+	davinci_cfg_reg_list(ssp_pins);
 
 	tnetv107x_devices_init(&evm_device_info);
 }
-- 
1.7.1
