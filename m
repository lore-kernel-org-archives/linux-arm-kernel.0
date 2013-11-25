From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 12:15:09 +0000
Subject: [PATCH 2/3] ARM: dts: Disable I2C controllers by default on Exynos5250
In-Reply-To: <1385381710-5212-1-git-send-email-broonie@kernel.org>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
Message-ID: <1385381710-5212-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Ensure that unused I2C controllers are not activated, causing problems due
to inappropriate pinmuxing or similar, by marking the controllers as
disabled by default and requiring boards to explicitly enable those that
are in use.

Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/cros5250-common.dtsi    | 12 ++++++++----
 arch/arm/boot/dts/exynos5250-arndale.dts  | 32 ++++++++-----------------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 25 +++++-------------------
 arch/arm/boot/dts/exynos5250.dtsi         | 10 ++++++++++
 4 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index 0fcca2930c61..7dbba0859a1d 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -30,6 +30,7 @@
 	};
 
 	i2c at 12C60000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
@@ -173,6 +174,7 @@
 	};
 
 	i2c at 12C70000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
@@ -186,6 +188,7 @@
 	};
 
 	i2c at 12C80000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 
@@ -196,30 +199,31 @@
 	};
 
 	i2c at 12C90000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 	};
 
 	i2c at 12CA0000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 	};
 
 	i2c at 12CB0000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 	};
 
-	i2c at 12CC0000 {
-		status = "disabled";
-	};
-
 	i2c at 12CD0000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 	};
 
 	i2c at 12CE0000 {
+		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 0385b58116ec..6fbe89fd7d41 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -34,6 +34,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
 		samsung,i2c-slave-addr = <0x66>;
+		status = "okay";
 
 		s5m8767_pmic at 66 {
 			compatible = "samsung,s5m8767-pmic";
@@ -319,11 +320,9 @@
 		};
 	};
 
-	i2c at 12C70000 {
-		status = "disabled";
-	};
-
 	i2c at 12C80000 {
+		status = "okay";
+
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 		samsung,i2c-slave-addr = <0x50>;
@@ -335,7 +334,10 @@
 	};
 
 	i2c at 12C90000 {
+		status = "okay";
+
 		wm1811a at 1a {
+
 			compatible = "wlf,wm1811";
 			reg = <0x1a>;
 
@@ -353,23 +355,9 @@
 		};
 	};
 
-	i2c at 12CA0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CB0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CC0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CD0000 {
-		status = "disabled";
-	};
-
 	i2c at 12CE0000 {
+		status = "okay";
+
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 		samsung,i2c-slave-addr = <0x38>;
@@ -380,10 +368,6 @@
 		};
 	};
 
-	i2c at 121D0000 {
-		status = "disabled";
-	};
-
 	dwmmc_0: dwmmc0 at 12200000 {
 		num-slots = <1>;
 		supports-highspeed;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 5d0395e07eee..a17b1a0a8abc 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -30,6 +30,7 @@
 	i2c at 12C60000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
+		status = "okay";
 
 		eeprom at 50 {
 			compatible = "samsung,s524ad0xd1";
@@ -64,6 +65,7 @@
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
+		status = "okay";
 
 		eeprom at 51 {
 			compatible = "samsung,s524ad0xd1";
@@ -89,6 +91,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <40000>;
 		samsung,i2c-slave-addr = <0x38>;
+		status = "okay";
 
 		sata-phy {
 			compatible = "samsung,sata-phy";
@@ -103,6 +106,7 @@
 	i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
+		status = "okay";
 
 		hdmiddc at 50 {
 			compatible = "samsung,exynos4210-hdmiddc";
@@ -110,29 +114,10 @@
 		};
 	};
 
-	i2c at 12C90000 {
-		status = "disabled";
-	};
-
-	i2c at 12CA0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CB0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CC0000 {
-		status = "disabled";
-	};
-
-	i2c at 12CD0000 {
-		status = "disabled";
-	};
-
 	i2c at 12CE0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
+		status = "okay";
 
 		hdmiphy at 38 {
 			compatible = "samsung,exynos4212-hdmiphy";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 9b58532854e1..3a4454620f6b 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -242,6 +242,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
+		status = "disabled";
 	};
 
 	i2c_1: i2c at 12C70000 {
@@ -254,6 +255,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
+		status = "disabled";
 	};
 
 	i2c_2: i2c at 12C80000 {
@@ -266,6 +268,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
+		status = "disabled";
 	};
 
 	i2c_3: i2c at 12C90000 {
@@ -278,6 +281,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
+		status = "disabled";
 	};
 
 	i2c_4: i2c at 12CA0000 {
@@ -290,6 +294,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c4_bus>;
+		status = "disabled";
 	};
 
 	i2c_5: i2c at 12CB0000 {
@@ -302,6 +307,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c5_bus>;
+		status = "disabled";
 	};
 
 	i2c_6: i2c at 12CC0000 {
@@ -314,6 +320,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c6_bus>;
+		status = "disabled";
 	};
 
 	i2c_7: i2c at 12CD0000 {
@@ -326,6 +333,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c7_bus>;
+		status = "disabled";
 	};
 
 	i2c_8: i2c at 12CE0000 {
@@ -336,6 +344,7 @@
 		#size-cells = <0>;
 		clocks = <&clock 302>;
 		clock-names = "i2c";
+		status = "disabled";
 	};
 
 	i2c at 121D0000 {
@@ -345,6 +354,7 @@
                 #size-cells = <0>;
 		clocks = <&clock 288>;
 		clock-names = "i2c";
+		status = "disabled";
 	};
 
 	spi_0: spi at 12d20000 {
-- 
1.8.4.4
