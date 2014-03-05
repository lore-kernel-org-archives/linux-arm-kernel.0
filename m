From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Mar 2014 00:27:15 +0800
Subject: [PATCH 5/5] ARM: sun6i: columbus: Enable the GMAC
In-Reply-To: <1394036835-22007-1-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
Message-ID: <1394036835-22007-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 Colombus board uses the GMAC with a Realtek RTL8211E-VB RGMII phy.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index e5adae3..19a0385 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -28,5 +28,17 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		gmac: ethernet at 01c30000 {
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
 };
-- 
1.9.0
