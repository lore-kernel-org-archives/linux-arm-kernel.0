From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  9 Dec 2011 16:59:04 -0700
Subject: [PATCH 2/3] arm/u300: Don't use PINMUX_MAP_PRIMARY*
In-Reply-To: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
References: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
Message-ID: <1323475145-26430-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next patch will remove these macros.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-u300/core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index e70ebd1..b4c6926 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1607,13 +1607,13 @@ static struct platform_device pinmux_device = {
 /* Pinmux settings */
 static struct pinmux_map __initdata u300_pinmux_map[] = {
 	/* anonymous maps for chip power and EMIFs */
-	PINMUX_MAP_PRIMARY_SYS_HOG("POWER", "power"),
-	PINMUX_MAP_PRIMARY_SYS_HOG("EMIF0", "emif0"),
-	PINMUX_MAP_PRIMARY_SYS_HOG("EMIF1", "emif1"),
+	PINMUX_MAP_SYS_HOG("POWER", "pinmux-u300", "power"),
+	PINMUX_MAP_SYS_HOG("EMIF0", "pinmux-u300", "emif0"),
+	PINMUX_MAP_SYS_HOG("EMIF1", "pinmux-u300", "emif1"),
 	/* per-device maps for MMC/SD, SPI and UART */
-	PINMUX_MAP_PRIMARY("MMCSD", "mmc0", "mmci"),
-	PINMUX_MAP_PRIMARY("SPI", "spi0", "pl022"),
-	PINMUX_MAP_PRIMARY("UART0", "uart0", "uart0"),
+	PINMUX_MAP("MMCSD", "pinmux-u300", "mmc0", "mmci"),
+	PINMUX_MAP("SPI", "pinmux-u300", "spi0", "pl022"),
+	PINMUX_MAP("UART0", "pinmux-u300", "uart0", "uart0"),
 };
 
 struct u300_mux_hog {
-- 
1.7.0.4
