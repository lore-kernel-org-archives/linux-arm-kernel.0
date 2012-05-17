From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:08 +0100
Subject: [PATCH 03/18] ARM: ux500: Provide auxdata to be used as name base
 clock search for nmk-i2c
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a way for find_clk() to complete its name-based
searches and still find the nmk-i2c clocks. As Device Tree has a
different naming structure to that of more traditional initialisation
methods, find_clk() not succeed without these bindings.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4584c74..b8331fe 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -757,6 +757,11 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e000, "gpio.6", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e080, "gpio.7", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0xa03fe000, "gpio.8", NULL),
+	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80004000, "nmk-i2c.0", NULL),
+	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80122000, "nmk-i2c.1", NULL),
+	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80128000, "nmk-i2c.2", NULL),
+	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80110000, "nmk-i2c.3", NULL),
+	OF_DEV_AUXDATA("st,nomadik-i2c", 0x8012a000, "nmk-i2c.4", NULL),
 	{},
 };
 
@@ -838,7 +843,6 @@ static void __init u8500_init_machine(void)
 		i2c_register_board_info(2, mop500_i2c2_devices,
 					ARRAY_SIZE(mop500_i2c2_devices));
 	}
-	mop500_i2c_init(parent);
 
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
-- 
1.7.9.5
