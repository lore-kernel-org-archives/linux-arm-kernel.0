From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Mar 2013 21:50:04 +0100
Subject: [PATCH 5/5] ARM: hackberry: dt: Add Ethernet controller to the
 Hackberry device tree
In-Reply-To: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363380605-6577-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index f84549a..3808c1a 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -23,8 +23,27 @@
 	};
 
 	soc {
+		pio: pinctrl at 01c20800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&hackberry_hogs>;
+
+			hackberry_hogs: hogs at 0 {
+				allwinner,pins = "PH19";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+
 		uart0: uart at 01c28000 {
 			status = "okay";
 		};
+
+		wemac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&wemac_pins_a>;
+			status = "ok";
+			allwinner,power-gpios = <&pio 7 19 0>;
+		};
 	};
 };
-- 
1.7.10.4
