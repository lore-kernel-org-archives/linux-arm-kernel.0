From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Thu, 12 Jun 2014 17:11:25 +0200
Subject: [PATCH 2/2] ARM: tegra: tamonten: add the display to the Medcom Wide
In-Reply-To: <1402585885-28247-1-git-send-email-alban.bedel@avionic-design.de>
References: <1402585885-28247-1-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <1402585885-28247-2-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RGB output and add the panel definition to the Medcom Wide
DTS. Also add a label to the backlight defintion to reference it in
the panel definition.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 arch/arm/boot/dts/tegra20-medcom-wide.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index 0cd05f7..97a9101 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -10,6 +10,15 @@
 		status = "okay";
 	};
 
+	host1x at 50000000 {
+		dc at 54200000 {
+			rgb {
+				status = "okay";
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
 	i2c at 7000c000 {
 		wm8903: wm8903 at 1a {
 			compatible = "wlf,wm8903";
@@ -30,7 +39,7 @@
 		};
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 5000000>;
 
@@ -38,6 +47,15 @@
 		default-brightness-level = <6>;
 	};
 
+	panel: panel {
+		compatible = "innolux,n156bge-l21", "simple-panel";
+
+		power-supply =  <&vdd_1v8_reg>, <&vdd_3v3_reg>;
+		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+	};
+
 	sound {
 		compatible = "ad,tegra-audio-wm8903-medcom-wide",
 			     "nvidia,tegra-audio-wm8903";
-- 
2.0.0
