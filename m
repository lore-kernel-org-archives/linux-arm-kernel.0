From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:47 +0100
Subject: [PATCH v2 05/14] ARM: Kirkwood: Convert iConnect to pinctrl.
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-iconnect.dts |   51 +++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-iconnect.c |   17 -----------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index d97cd9d..504f16b 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	model = "Iomega Iconnect";
@@ -18,6 +19,56 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pinctrl-0 = < &pmx_gpio_12 &pmx_gpio_35
+				      &pmx_gpio_41 &pmx_gpio_42
+				      &pmx_gpio_43 &pmx_gpio_44
+				      &pmx_gpio_45 &pmx_gpio_46
+				      &pmx_gpio_47 &pmx_gpio_48 >;
+			pinctrl-names = "default";
+
+			pmx_gpio_12: pmx-gpio-12 {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_35: pmx-gpio-35 {
+				marvell,pins = "mpp35";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_41: pmx-gpio-41 {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_42: pmx-gpio-42 {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_43: pmx-gpio-43 {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_44: pmx-gpio-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_45: pmx-gpio-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_46: pmx-gpio-46 {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_47: pmx-gpio-47 {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+			pmx_gpio_48: pmx-gpio-48 {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+		};
 		i2c at 11000 {
 			status = "okay";
 
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index d084b1e..aeba479 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -21,30 +21,13 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data iconnect_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
 };
 
-static unsigned int iconnect_mpp_config[] __initdata = {
-	MPP12_GPIO,
-	MPP35_GPIO,
-	MPP41_GPIO,
-	MPP42_GPIO,
-	MPP43_GPIO,
-	MPP44_GPIO,
-	MPP45_GPIO,
-	MPP46_GPIO,
-	MPP47_GPIO,
-	MPP48_GPIO,
-	0
-};
-
 void __init iconnect_init(void)
 {
-	kirkwood_mpp_conf(iconnect_mpp_config);
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&iconnect_ge00_data);
 }
-- 
1.7.10.4
