From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  1 Dec 2017 14:44:51 +0100
Subject: [PATCH v4 10/10] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when used
 as LDOs
In-Reply-To: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <afc22693e34c11231fc85a0dc6af3ffb340ba9b2.1512135804.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
ldo_io0 and ldo_io1.

Let's add the pinctrl properties to the said regulators.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 0ef959d..fd55b89 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -52,6 +52,16 @@
 		compatible = "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
 	};
 
 	regulators {
@@ -119,11 +129,15 @@
 		};
 
 		reg_ldo_io0: ldo-io0 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio0_ldo>;
 			/* Disable by default to avoid conflicts with GPIO */
 			status = "disabled";
 		};
 
 		reg_ldo_io1: ldo-io1 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio1_ldo>;
 			/* Disable by default to avoid conflicts with GPIO */
 			status = "disabled";
 		};
-- 
git-series 0.9.1
