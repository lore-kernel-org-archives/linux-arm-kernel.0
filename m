From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 20 Dec 2015 01:32:10 +0200
Subject: [PATCH 1/3] arm: dts: phy3250: add lcd and backlight fixed regulators
In-Reply-To: <1450567932-22994-1-git-send-email-vz@mleia.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
Message-ID: <1450567932-22994-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phytec PHY3250 board has GPIO controlled regulators for LCD and
backlight, add their descriptions to board DTS file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/phy3250.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 7d253bb..34e15fd 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -25,6 +25,28 @@
 		reg = <0x80000000 0x4000000>;
 	};
 
+	regulators {
+		backlight_reg: fixed-regulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight_reg";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio 5 4 0>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		lcd_reg: fixed-regulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "lcd_reg";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio 5 0 0>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+	};
+
 	ahb {
 		mac: ethernet at 31060000 {
 			phy-mode = "rmii";
-- 
2.1.4
