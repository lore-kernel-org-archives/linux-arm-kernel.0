From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 11:58:51 -0700
Subject: [PATCH 4/5] ARM: Tegra: Create defines for GPIO names
In-Reply-To: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
Message-ID: <1298487532-5000-5-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ensures they're kept in sync between platform_data definitions and
the GPIO table initialization.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
NOTE: This patch will not apply until Olof's recently posted
boards-for-next branch is merged.

 arch/arm/mach-tegra/board-harmony-pinmux.c  |   12 ++++++------
 arch/arm/mach-tegra/board-harmony.c         |   12 ++++++------
 arch/arm/mach-tegra/board-harmony.h         |    7 +++++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   10 +++++-----
 arch/arm/mach-tegra/board-seaboard.c        |    6 +++---
 arch/arm/mach-tegra/board-seaboard.h        |    3 +++
 6 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 98368d9..3ada474 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -141,12 +141,12 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 };
 
 static struct tegra_gpio_table gpio_table[] = {
-	{ .gpio = TEGRA_GPIO_PI5,	.enable = true	}, /* mmc2 cd	*/
-	{ .gpio = TEGRA_GPIO_PH1,	.enable = true	}, /* mmc2 wp	*/
-	{ .gpio = TEGRA_GPIO_PT3,	.enable = true	}, /* mmc2 pwr	*/
-	{ .gpio = TEGRA_GPIO_PH2,	.enable = true	}, /* mmc4 cd	*/
-	{ .gpio = TEGRA_GPIO_PH3,	.enable = true	}, /* mmc4 wp	*/
-	{ .gpio = TEGRA_GPIO_PI6,	.enable = true	}, /* mmc4 pwr	*/
+	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_CD,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_WP,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_POWER,		.enable = true	},
 };
 
 void harmony_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 49224e9..2c4a234 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -91,15 +91,15 @@ static struct tegra_sdhci_platform_data sdhci_pdata1 = {
 };
 
 static struct tegra_sdhci_platform_data sdhci_pdata2 = {
-	.cd_gpio	= TEGRA_GPIO_PI5,
-	.wp_gpio	= TEGRA_GPIO_PH1,
-	.power_gpio	= TEGRA_GPIO_PT3,
+	.cd_gpio	= TEGRA_GPIO_SD2_CD,
+	.wp_gpio	= TEGRA_GPIO_SD2_WP,
+	.power_gpio	= TEGRA_GPIO_SD2_POWER,
 };
 
 static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= TEGRA_GPIO_PH2,
-	.wp_gpio	= TEGRA_GPIO_PH3,
-	.power_gpio	= TEGRA_GPIO_PI6,
+	.cd_gpio	= TEGRA_GPIO_SD4_CD,
+	.wp_gpio	= TEGRA_GPIO_SD4_WP,
+	.power_gpio	= TEGRA_GPIO_SD4_POWER,
 	.is_8bit	= 1,
 };
 
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 09ca775..4fe33b8 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -17,6 +17,13 @@
 #ifndef _MACH_TEGRA_BOARD_HARMONY_H
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
+#define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
+#define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
+#define TEGRA_GPIO_SD2_POWER		TEGRA_GPIO_PT3
+#define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
+#define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
+#define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
+
 void harmony_pinmux_init(void);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 2d6ad83..7b6f38c 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -161,11 +161,11 @@ static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
 
 
 static struct tegra_gpio_table gpio_table[] = {
-	{ .gpio = TEGRA_GPIO_PI5,	.enable = true	}, /* mmc2 cd	 */
-	{ .gpio = TEGRA_GPIO_PH1,	.enable = true	}, /* mmc2 wp	 */
-	{ .gpio = TEGRA_GPIO_PI6,	.enable = true	}, /* mmc2 pwr	 */
-	{ .gpio = TEGRA_GPIO_LIDSWITCH,	.enable = true	}, /* lid switch */
-	{ .gpio = TEGRA_GPIO_POWERKEY,	.enable = true	}, /* power key	 */
+	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true	},
 };
 
 void __init seaboard_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 6ca9e61..eb28dbd 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -103,9 +103,9 @@ static struct tegra_sdhci_platform_data sdhci_pdata1 = {
 };
 
 static struct tegra_sdhci_platform_data sdhci_pdata3 = {
-	.cd_gpio	= TEGRA_GPIO_PI5,
-	.wp_gpio	= TEGRA_GPIO_PH1,
-	.power_gpio	= TEGRA_GPIO_PI6,
+	.cd_gpio	= TEGRA_GPIO_SD2_CD,
+	.wp_gpio	= TEGRA_GPIO_SD2_WP,
+	.power_gpio	= TEGRA_GPIO_SD2_POWER,
 };
 
 static struct tegra_sdhci_platform_data sdhci_pdata4 = {
diff --git a/arch/arm/mach-tegra/board-seaboard.h b/arch/arm/mach-tegra/board-seaboard.h
index a098e35..d8415e1 100644
--- a/arch/arm/mach-tegra/board-seaboard.h
+++ b/arch/arm/mach-tegra/board-seaboard.h
@@ -17,6 +17,9 @@
 #ifndef _MACH_TEGRA_BOARD_SEABOARD_H
 #define _MACH_TEGRA_BOARD_SEABOARD_H
 
+#define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
+#define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
+#define TEGRA_GPIO_SD2_POWER		TEGRA_GPIO_PI6
 #define TEGRA_GPIO_LIDSWITCH		TEGRA_GPIO_PC7
 #define TEGRA_GPIO_USB1			TEGRA_GPIO_PD0
 #define TEGRA_GPIO_POWERKEY		TEGRA_GPIO_PV2
-- 
1.7.1
