From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Jan 2014 15:00:14 +0800
Subject: [PATCH v2 13/16] ARM: dts: sun7i: cubietruck: Enable the GMAC
In-Reply-To: <1389337217-29032-1-git-send-email-wens@csie.org>
References: <1389337217-29032-1-git-send-email-wens@csie.org>
Message-ID: <1389337217-29032-14-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CubieTruck uses the GMAC with an RGMII phy.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f9dcb61..025ce52 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -51,6 +51,18 @@
 			pinctrl-0 = <&i2c2_pins_a>;
 			status = "okay";
 		};
+
+		gmac: ethernet at 01c50000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_rgmii_a>;
+			phy = <&phy1>;
+			phy-mode = "rgmii";
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
 	};
 
 	leds {
-- 
1.8.5.2
