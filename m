From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 20 Oct 2015 17:11:04 +0800
Subject: [PATCH 4/4] ARM: dts: rockchip: Add the OTP gpio pinctrl
In-Reply-To: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1445332264-6054-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..b59c451 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -447,8 +447,9 @@
 		clock-names = "tsadc", "apb_pclk";
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		pinctrl-names = "default";
-		pinctrl-0 = <&otp_out>;
+		pinctrl-names = "default", "otp_out";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
 		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
@@ -1273,6 +1274,10 @@
 		};
 
 		tsadc {
+			otp_gpio: otp-gpio {
+				rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
 			otp_out: otp-out {
 				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
 			};
-- 
1.9.1
