From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 15:21:11 -0600
Subject: [PATCH 1/3] arm64: dts: apq8016-sbc: enable UART0 on LS connector
In-Reply-To: <1449782473-20880-1-git-send-email-robh@kernel.org>
References: <1449782473-20880-1-git-send-email-robh@kernel.org>
Message-ID: <1449782473-20880-2-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LS UART0 is not used by anything else and should be enabled for
expansion boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 6b8abbe..7505fa3 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -27,6 +27,13 @@
 	};
 
 	soc {
+		serial at 78af000 {
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			pinctrl-1 = <&blsp1_uart1_sleep>;
+		};
+
 		serial at 78b0000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
-- 
2.5.0
