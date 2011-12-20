From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 20:03:22 -0800
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
Message-ID: <1324353802-31774-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silence a bunch of section warnings, and mark some of the init functions as
__init.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/board-harmony-pinmux.c   |    8 ++++----
 arch/arm/mach-tegra/board-paz00-pinmux.c     |    8 ++++----
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |   16 ++++++++--------
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 465808c..84cfbef 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -25,7 +25,7 @@
 #include "board-harmony.h"
 #include "board-pinmux.h"
 
-static struct tegra_pingroup_config harmony_pinmux[] = {
+static __initdata struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -144,7 +144,7 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-static struct tegra_gpio_table gpio_table[] = {
+static __initdata struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true	},
@@ -157,14 +157,14 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_EXT_MIC_EN,	.enable = true	},
 };
 
-static struct tegra_board_pinmux_conf conf = {
+static __initdata struct tegra_board_pinmux_conf conf = {
 	.pgs = harmony_pinmux,
 	.pg_count = ARRAY_SIZE(harmony_pinmux),
 	.gpios = gpio_table,
 	.gpio_count = ARRAY_SIZE(gpio_table),
 };
 
-void harmony_pinmux_init(void)
+void __init harmony_pinmux_init(void)
 {
 	tegra_board_pinmux_init(&conf, NULL);
 }
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index c775572..01997fa 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -25,7 +25,7 @@
 #include "board-paz00.h"
 #include "board-pinmux.h"
 
-static struct tegra_pingroup_config paz00_pinmux[] = {
+static __initdata struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -144,7 +144,7 @@ static struct tegra_pingroup_config paz00_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-static struct tegra_gpio_table gpio_table[] = {
+static __initdata struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
@@ -154,14 +154,14 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
-static struct tegra_board_pinmux_conf conf = {
+static __initdata struct tegra_board_pinmux_conf conf = {
 	.pgs = paz00_pinmux,
 	.pg_count = ARRAY_SIZE(paz00_pinmux),
 	.gpios = gpio_table,
 	.gpio_count = ARRAY_SIZE(gpio_table),
 };
 
-void paz00_pinmux_init(void)
+void __init paz00_pinmux_init(void)
 {
 	tegra_board_pinmux_init(&conf, NULL);
 }
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index ad63a89..40236e9 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -179,14 +179,14 @@ static __initdata struct tegra_pingroup_config ventana_pinmux[] = {
 	{TEGRA_PINGROUP_SPIG, TEGRA_MUX_SPI2_ALT, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 };
 
-static struct tegra_gpio_table common_gpio_table[] = {
+static __initdata struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true },
 	{ .gpio = TEGRA_GPIO_SD2_WP,		.enable = true },
 	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true },
 	{ .gpio = TEGRA_GPIO_CDC_IRQ,		.enable = true },
 };
 
-static struct tegra_gpio_table seaboard_gpio_table[] = {
+static __initdata struct tegra_gpio_table seaboard_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true },
 	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true },
 	{ .gpio = TEGRA_GPIO_HP_DET,		.enable = true },
@@ -194,7 +194,7 @@ static struct tegra_gpio_table seaboard_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_USB1,		.enable = true },
 };
 
-static struct tegra_gpio_table ventana_gpio_table[] = {
+static __initdata struct tegra_gpio_table ventana_gpio_table[] = {
 	/* hp_det */
 	{ .gpio = TEGRA_GPIO_PW2,		.enable = true },
 	/* int_mic_en */
@@ -203,14 +203,14 @@ static struct tegra_gpio_table ventana_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_PX1,		.enable = true },
 };
 
-static struct tegra_board_pinmux_conf common_conf = {
+static __initdata struct tegra_board_pinmux_conf common_conf = {
 	.pgs = common_pinmux,
 	.pg_count = ARRAY_SIZE(common_pinmux),
 	.gpios = common_gpio_table,
 	.gpio_count = ARRAY_SIZE(common_gpio_table),
 };
 
-static struct tegra_board_pinmux_conf seaboard_conf = {
+static __initdata struct tegra_board_pinmux_conf seaboard_conf = {
 	.pgs = seaboard_pinmux,
 	.pg_count = ARRAY_SIZE(seaboard_pinmux),
 	.drives = seaboard_drive_pinmux,
@@ -219,19 +219,19 @@ static struct tegra_board_pinmux_conf seaboard_conf = {
 	.gpio_count = ARRAY_SIZE(seaboard_gpio_table),
 };
 
-static struct tegra_board_pinmux_conf ventana_conf = {
+static __initdata struct tegra_board_pinmux_conf ventana_conf = {
 	.pgs = ventana_pinmux,
 	.pg_count = ARRAY_SIZE(ventana_pinmux),
 	.gpios = ventana_gpio_table,
 	.gpio_count = ARRAY_SIZE(ventana_gpio_table),
 };
 
-void seaboard_pinmux_init(void)
+void __init seaboard_pinmux_init(void)
 {
 	tegra_board_pinmux_init(&common_conf, &seaboard_conf);
 }
 
-void ventana_pinmux_init(void)
+void __init ventana_pinmux_init(void)
 {
 	tegra_board_pinmux_init(&common_conf, &ventana_conf);
 }
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index f7ded33..c85626c 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -144,7 +144,7 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 };
 
-static struct tegra_gpio_table gpio_table[] = {
+static __initdata struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_SD4_CD, .enable = true	}, /* mmc4 cd */
 	{ .gpio = TRIMSLICE_GPIO_SD4_WP, .enable = true	}, /* mmc4 wp */
 
@@ -152,7 +152,7 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_USB2_RST,  .enable = true }, /* USB2 PHY rst */
 };
 
-static struct tegra_board_pinmux_conf conf = {
+static __initdata struct tegra_board_pinmux_conf conf = {
 	.pgs = trimslice_pinmux,
 	.pg_count = ARRAY_SIZE(trimslice_pinmux),
 	.gpios = gpio_table,
-- 
1.7.5.4
