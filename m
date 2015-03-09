From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  9 Mar 2015 17:40:36 +0100
Subject: [PATCH 3/3] ARM: dts: imx6qdl: disable PWMs by default
In-Reply-To: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
References: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1425919236-6664-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PWMs are only useful if they are actually connected to an output pin,
let users enable them explicitly in their device trees where they should
also set up the pin configuration.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ce37bbf1..9cc30a4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -380,6 +380,7 @@
 				clocks = <&clks IMX6QDL_CLK_IPG>,
 					 <&clks IMX6QDL_CLK_PWM1>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			pwm2: pwm at 02084000 {
@@ -390,6 +391,7 @@
 				clocks = <&clks IMX6QDL_CLK_IPG>,
 					 <&clks IMX6QDL_CLK_PWM2>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			pwm3: pwm at 02088000 {
@@ -400,6 +402,7 @@
 				clocks = <&clks IMX6QDL_CLK_IPG>,
 					 <&clks IMX6QDL_CLK_PWM3>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			pwm4: pwm at 0208c000 {
@@ -410,6 +413,7 @@
 				clocks = <&clks IMX6QDL_CLK_IPG>,
 					 <&clks IMX6QDL_CLK_PWM4>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			can1: flexcan at 02090000 {
-- 
2.1.4
