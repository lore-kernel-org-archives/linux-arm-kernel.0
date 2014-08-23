From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 23 Aug 2014 10:11:47 +0100
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <20140823091058.GO30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
Message-ID: <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabeeh Khoury <rabeeh@solid-run.com>
To: Shawn Guo <shawn.guo@freescale.com>

HummingBoard after rev 2.0 and the production one starting rev 3.0 uses
gpio 3,5 (EIM_DA5 pad) as the gpio infra red receiver input.

Since the original Carrier1 board is obsolete and we are retiring it,
update the DT file for this.  This will mean IR reception will not
work on Carrier1 with this DT file.

Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index bf38072a2779..1f355804c2cb 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -11,9 +11,9 @@
 
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 2 1>;
+		gpios = <&gpio3 5 1>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_hummingboard_gpio1_2>;
+		pinctrl-0 = <&pinctrl_hummingboard_gpio3_5>;
 	};
 
 	regulators {
@@ -103,9 +103,9 @@
 			>;
 		};
 
-		pinctrl_hummingboard_gpio1_2: hummingboard-gpio1_2 {
+		pinctrl_hummingboard_gpio3_5: hummingboard-gpio3_5 {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000
 			>;
 		};
 
-- 
1.8.3.1
