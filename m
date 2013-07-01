From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:16:11 +0800
Subject: [PATCH 4/4] ARM: mxs: saif0 is the clock provider to sgtl5000
In-Reply-To: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1372666571-17276-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These systems all use saif0 as the mclock provider to codec sgtl5000.
Reflect that in device tree source, so that sgtl5000 can find the clock
by calling clk_get().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts |    2 +-
 arch/arm/boot/dts/imx28-evk.dts        |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts     |    2 +-
 arch/arm/boot/dts/imx28.dtsi           |    1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 43bf3c7..0e7fed4 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -147,7 +147,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				pcf8563: rtc at 51 {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 3637bf3..dccb223 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -193,7 +193,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				at24 at 51 {
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 880df2f..44d9da5 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -184,7 +184,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&saif0>;
 				};
 
 				eeprom: eeprom at 51 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6a8acb0..9524a05 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -837,6 +837,7 @@
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
 				interrupts = <59 80>;
+				#clock-cells = <0>;
 				clocks = <&clks 53>;
 				dmas = <&dma_apbx 4>;
 				dma-names = "rx-tx";
-- 
1.7.9.5
