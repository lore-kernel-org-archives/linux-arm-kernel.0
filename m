From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 16 Oct 2017 12:08:24 +0200
Subject: [PATCH 2/2] ARM: davinci: make davinci_soc_info structures const
In-Reply-To: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
References: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1508148504-2771-3-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup patch for [PATCH 1/2].

Make the structures const as they are either passed to the function
davinci_common_init having the argument as const or their field cpu_clks
of type struct clk_lookup * is passed to the function davinci_clk_init.
So, the fields are never modified and the structures can be const. 

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-davinci/da830.c  | 2 +-
 arch/arm/mach-davinci/da850.c  | 2 +-
 arch/arm/mach-davinci/dm355.c  | 2 +-
 arch/arm/mach-davinci/dm365.c  | 2 +-
 arch/arm/mach-davinci/dm644x.c | 2 +-
 arch/arm/mach-davinci/dm646x.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index bd88470..ed0b700 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1194,7 +1194,7 @@ int __init da830_register_gpio(void)
 	.clocksource_id	= T0_BOT,
 };
 
-static struct davinci_soc_info davinci_soc_info_da830 = {
+static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.io_desc		= da830_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da830_io_desc),
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 07d6f0e..04a58a3 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1347,7 +1347,7 @@ int __init da850_register_gpio(void)
 	return da8xx_register_gpio(&da850_gpio_platform_data);
 }
 
-static struct davinci_soc_info davinci_soc_info_da850 = {
+static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index bd50367..938747f 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1006,7 +1006,7 @@ struct platform_device dm355_serial_device[] = {
 	}
 };
 
-static struct davinci_soc_info davinci_soc_info_dm355 = {
+static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.io_desc		= dm355_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm355_io_desc),
 	.jtag_id_reg		= 0x01c40028,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8be04ec..bcf1494 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1108,7 +1108,7 @@ struct platform_device dm365_serial_device[] = {
 	}
 };
 
-static struct davinci_soc_info davinci_soc_info_dm365 = {
+static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.io_desc		= dm365_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm365_io_desc),
 	.jtag_id_reg		= 0x01c40028,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b437c37..6b41e1c 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -899,7 +899,7 @@ struct platform_device dm644x_serial_device[] = {
 	}
 };
 
-static struct davinci_soc_info davinci_soc_info_dm644x = {
+static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.io_desc		= dm644x_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm644x_io_desc),
 	.jtag_id_reg		= 0x01c40028,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index da21353..b72e04a 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -882,7 +882,7 @@ struct platform_device dm646x_serial_device[] = {
 	}
 };
 
-static struct davinci_soc_info davinci_soc_info_dm646x = {
+static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.io_desc		= dm646x_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm646x_io_desc),
 	.jtag_id_reg		= 0x01c40028,
-- 
1.9.1
