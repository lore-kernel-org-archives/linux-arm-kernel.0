From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:41 +0100
Subject: [PATCH 2/8] arm64: dts: db820c: add support to LS-UART0
In-Reply-To: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466452907-23290-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to 4 pin UART0 on LS expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 01916a5..2851442 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -16,6 +16,7 @@
 / {
 	aliases {
 		serial0 = &blsp2_uart1;
+		serial1 = &blsp2_uart2;
 	};
 
 	chosen {
@@ -30,5 +31,13 @@
 			pinctrl-0 = <&blsp2_uart1_2pins_default>;
 			pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
 		};
+
+		serial at 75b1000 {
+			label = "LS-UART0";
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_uart2_4pins_default>;
+			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
+		};
 	};
 };
-- 
2.7.4
