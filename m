From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:15 +0100
Subject: [PATCH 15/40] ARM: ux500: Remove Light sensor Rohm BH1780GLI when
 booting with ATAGs
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 66d466b..e0db81d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -55,13 +55,6 @@ struct ab8500_platform_data ab8500_platdata = {
 	.regulator	= &ab8500_regulator_plat_data,
 };
 
-static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
-	{
-		/* Light sensor Rohm BH1780GLI */
-		I2C_BOARD_INFO("bh1780", 0x29),
-	},
-};
-
 static void __init mop500_i2c_init(struct device *parent)
 {
 	db8500_add_i2c0(parent, NULL);
@@ -249,9 +242,6 @@ static void __init mop500_init_machine(void)
 	mop500_spi_init(parent);
 	mop500_uart_init(parent);
 
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
@@ -301,9 +291,6 @@ static void __init hrefv60_init_machine(void)
 	mop500_spi_init(parent);
 	mop500_uart_init(parent);
 
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
-- 
1.8.1.2
