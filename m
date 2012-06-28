From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:05 +0800
Subject: [PATCH 09/11] ARM: dts: mxs: enable rtc for imx23 and imx28
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable rtc for imx23 and imx28.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    3 ++-
 arch/arm/boot/dts/imx28.dtsi |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index e78c1f4..a94ba1d 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -289,8 +289,9 @@
 			};
 
 			rtc at 8005c000 {
+				compatible = "fsl,imx23-rtc", "fsl,stmp3xxx-rtc";
 				reg = <0x8005c000 2000>;
-				status = "disabled";
+				interrupts = <22>;
 			};
 
 			pwm at 80064000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 03ddaac..f44ad99 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -527,9 +527,9 @@
 			};
 
 			rtc at 80056000 {
+				compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
 				reg = <0x80056000 2000>;
-				interrupts = <28 29>;
-				status = "disabled";
+				interrupts = <29>;
 			};
 
 			i2c0: i2c at 80058000 {
-- 
1.7.5.4
