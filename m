From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  9 Oct 2015 09:55:21 +0100
Subject: [PATCH v2 3/4] arm64: dts: apq8016-sbc: enable i2c buses on LS and HS
In-Reply-To: <1444380825-1355-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444380825-1355-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444380921-1508-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i2c buses on low speed and high speed expansion
connectors on DB410C.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 3fc3be4..cd1d0b5 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -34,6 +34,21 @@
 			pinctrl-1 = <&blsp1_uart2_sleep>;
 		};
 
+		i2c at 78b6000 {
+		/* On Low speed expansion */
+			status = "okay";
+		};
+
+		i2c at 78b8000 {
+		/* On High speed expansion */
+			status = "okay";
+		};
+
+		i2c at 78ba000 {
+		/* On Low speed expansion */
+			status = "okay";
+		};
+
 		leds {
 			pinctrl-names = "default";
 			pinctrl-0 = <&msmgpio_leds>,
-- 
1.9.1
