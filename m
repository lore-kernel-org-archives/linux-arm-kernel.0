From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:10:09 +0200
Subject: [PATCH 4/4] ARM: sun7i: olinuxino-micro: Enable the EMAC
In-Reply-To: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378890609-28563-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-olinuxino-micro has the EMAC wired in. Enable it in the DT so
that we can use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 34a6c02..9e77855 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -19,6 +19,21 @@
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy1>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PH2";
-- 
1.8.4
