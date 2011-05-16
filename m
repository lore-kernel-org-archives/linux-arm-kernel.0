From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 16 May 2011 20:10:58 +0200
Subject: [PATCH 4/4] ARM: tegra: paz00: cleanup sdhci ports
In-Reply-To: <1305569458-4821-1-git-send-email-marvin24@gmx.de>
References: <1305569458-4821-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305569458-4821-5-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal storage has no gpios connected to. Also the second
port is not connected at all, so remove it from the board file.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    3 ---
 arch/arm/mach-tegra/board-paz00.c        |   10 +---------
 arch/arm/mach-tegra/board-paz00.h        |    3 ---
 3 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index acee62e..bdd2627 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -144,9 +144,6 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
-	{ .gpio = TEGRA_GPIO_SD4_CD,	.enable = true },
-	{ .gpio = TEGRA_GPIO_SD4_WP,	.enable = true },
-	{ .gpio = TEGRA_GPIO_SD4_POWER,	.enable = true },
 	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
 };
 
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index e1e1959..7fdc409 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -71,7 +71,6 @@ static struct platform_device debug_uart = {
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device1,
-	&tegra_sdhci_device2,
 	&tegra_sdhci_device4,
 };
 
@@ -148,16 +147,10 @@ static struct tegra_sdhci_platform_data sdhci_pdata1 = {
 	.power_gpio	= TEGRA_GPIO_SD1_POWER,
 };
 
-static struct tegra_sdhci_platform_data sdhci_pdata2 = {
+static struct tegra_sdhci_platform_data sdhci_pdata4 = {
 	.cd_gpio	= -1,
 	.wp_gpio	= -1,
 	.power_gpio	= -1,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= TEGRA_GPIO_SD4_CD,
-	.wp_gpio	= TEGRA_GPIO_SD4_WP,
-	.power_gpio	= TEGRA_GPIO_SD4_POWER,
 	.is_8bit	= 1,
 };
 
@@ -168,7 +161,6 @@ static void __init tegra_paz00_init(void)
 	paz00_pinmux_init();
 
 	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
-	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
 
 	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 6b0b733..d4ff39d 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -20,9 +20,6 @@
 #define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
 #define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
 #define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PT3
-#define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
-#define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
-#define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
 #define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
 
 void paz00_pinmux_init(void);
-- 
1.7.4.2
