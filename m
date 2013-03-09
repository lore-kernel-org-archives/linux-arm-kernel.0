From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat,  9 Mar 2013 18:39:35 +1300
Subject: [PATCH 3/6] arm: dts: vt8500: Update Wondermedia SoC dtsi files for
 pinctrl driver
In-Reply-To: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1362807578-23089-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl nodes to the VIA VT8500 and Wondermedia SoC dtsi
files to support the pinctrl driver.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500.dtsi |    8 ++++++++
 arch/arm/boot/dts/wm8505.dtsi |    8 ++++++++
 arch/arm/boot/dts/wm8650.dtsi |    8 ++++++++
 arch/arm/boot/dts/wm8850.dtsi |    8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index cf31ced..16388c2 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -32,6 +32,14 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "via,vt8500-pinctrl";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <2>;
+			wm,pinmux = <0x00000001 0x00000001>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e74a1c0..c5aa4c9 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -47,6 +47,14 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8505-pinctrl";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <2>;
+			wm,pinmux = <0x80000000 0x80000000>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index db3c0a1..99c45e5 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -41,6 +41,14 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8650-pinctrl";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <2>;
+			wm,pinmux = <0x80000000 0x80000000>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index e8cbfdc..60094cd 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -48,6 +48,14 @@
 			#gpio-cells = <3>;
 		};
 
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8850-pinctrl";
+			gpio-controller;
+			reg = <0xd8110000 0x10000>;
+			#gpio-cells = <2>;
+			wm,pinmux = <0x80000000 0x80000000>;
+		};
+
 		pmc at d8130000 {
 			compatible = "via,vt8500-pmc";
 			reg = <0xd8130000 0x1000>;
-- 
1.7.9.5
