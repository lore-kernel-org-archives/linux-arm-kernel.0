From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:42 +0100
Subject: [PATCH 3/8] arm64: dts: db820c: add support to LS-I2C0
In-Reply-To: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466452907-23290-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to LS-I2C0 on LS expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 2851442..0d78c4e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -17,6 +17,7 @@
 	aliases {
 		serial0 = &blsp2_uart1;
 		serial1 = &blsp2_uart2;
+		i2c0	= &blsp1_i2c2;
 	};
 
 	chosen {
@@ -39,5 +40,12 @@
 			pinctrl-0 = <&blsp2_uart2_4pins_default>;
 			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
 		};
+
+		i2c at 07577000 {
+		/* On Low speed expansion */
+			label = "LS-I2C0";
+			status = "okay";
+		};
+
 	};
 };
-- 
2.7.4
