From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 25 Jun 2013 11:00:00 -0300
Subject: [PATCH 2/3] ARM: dts: mx28: Provide a codec clock
In-Reply-To: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9e13f345887 (ASoC: sgtl5000: Let the codec acquire its clock) it is 
necessary to pass a codec clock to the sgtl5000 driver.

Since the saif mclk cannot be passed as a real clock within the clock framework,
let's pass a dummy one to the codec driver.

The mxs-saif driver will activate the codec clock.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts | 2 +-
 arch/arm/boot/dts/imx28-evk.dts        | 2 +-
 arch/arm/boot/dts/imx28-m28evk.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 43bf3c7..f26bf2f 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -147,7 +147,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&clks 65>;
 				};
 
 				pcf8563: rtc at 51 {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 3637bf3..28f20b6 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -193,7 +193,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&clks 65>;
 				};
 
 				at24 at 51 {
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 880df2f..a09c5bf 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -184,7 +184,7 @@
 					reg = <0x0a>;
 					VDDA-supply = <&reg_3p3v>;
 					VDDIO-supply = <&reg_3p3v>;
-
+					clocks = <&clks 65>;
 				};
 
 				eeprom: eeprom at 51 {
-- 
1.8.1.2
