From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 12 Aug 2011 16:54:57 -0600
Subject: [RFC PATCH 12/12] arm/tegra: Remove temporary gpio/pinmux
	registration workaround
In-Reply-To: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313189697-21287-13-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit "arm/tegra: Prevent duplicate gpio/pinmux pdev
registration with dt"; board-dt.c no long calls harmony/
seaboard_pinmux_init(), so the workaround is no longer needed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-pinmux.c  |    5 +----
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 130018d..e99b456 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -14,8 +14,6 @@
  *
  */
 
-#include <asm/mach-types.h>
-
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <mach/pinmux.h>
@@ -163,8 +161,7 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void harmony_pinmux_init(void)
 {
-	if (machine_is_harmony())
-		platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index bc4dc17..f092298 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -12,8 +12,6 @@
  *
  */
 
-#include <asm/mach-types.h>
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
@@ -178,8 +176,7 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void __init seaboard_pinmux_init(void)
 {
-	if (machine_is_seaboard())
-		platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
 
-- 
1.7.0.4
