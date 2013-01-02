From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 14:53:22 -0700
Subject: [PATCH V2 3/3] ARM: tegra: paz00: enable HDMI port
In-Reply-To: <1357163602-10777-1-git-send-email-swarren@wwwdotorg.org>
References: <1357163602-10777-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357163602-10777-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Limit DDC I2C speed to 100KHz.
---
 arch/arm/boot/dts/tegra20-paz00.dts |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 6a93d14..80d9635 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -10,6 +10,18 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	host1x {
+		hdmi {
+			status = "okay";
+
+			vdd-supply = <&hdmi_vdd_reg>;
+			pll-supply = <&hdmi_pll_reg>;
+
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -252,9 +264,9 @@
 		};
 	};
 
-	i2c at 7000c400 {
+	hdmi_ddc: i2c at 7000c400 {
 		status = "okay";
-		clock-frequency = <400000>;
+		clock-frequency = <100000>;
 	};
 
 	nvec {
@@ -367,13 +379,13 @@
 					regulator-max-microvolt = <1800000>;
 				};
 
-				ldo7 {
+				hdmi_vdd_reg: ldo7 {
 					regulator-name = "+3.3vs_ldo7,avdd_hdmi";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 				};
 
-				ldo8 {
+				hdmi_pll_reg: ldo8 {
 					regulator-name = "+1.8vs_ldo8,avdd_hdmi_pll";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-- 
1.7.10.4
