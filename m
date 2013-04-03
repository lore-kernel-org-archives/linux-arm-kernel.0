From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed,  3 Apr 2013 19:24:49 +1300
Subject: [PATCHv5 5/7] arm: dts: vt8500: Update Wondermedia SoC dtsi files for
 pinctrl driver
In-Reply-To: <1364970291-17721-1-git-send-email-linux@prisktech.co.nz>
References: <1364970291-17721-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1364970291-17721-6-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl nodes to the VIA VT8500 and Wondermedia SoC dtsi
files to support the pinctrl driver.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500.dtsi |    9 +++++++++
 arch/arm/boot/dts/wm8505.dtsi |    9 +++++++++
 arch/arm/boot/dts/wm8650.dtsi |    9 +++++++++
 arch/arm/boot/dts/wm8850.dtsi |    9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index cf31ced..8e87aa9 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -32,6 +32,15 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "via,vt8500-pinctrl";
+			reg = <0xd8110000 0x10000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e74a1c0..e4f768a 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -47,6 +47,15 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8505-pinctrl";
+			reg = <0xd8110000 0x10000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index db3c0a1..01b6a8d 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -41,6 +41,15 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8650-pinctrl";
+			reg = <0xd8110000 0x10000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index e8cbfdc..297aa05 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -48,6 +48,15 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8850-pinctrl";
+			reg = <0xd8110000 0x10000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
-- 
1.7.9.5
