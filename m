From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 15:21:12 -0600
Subject: [PATCH 2/3] arm64: dts: apq8016-sbc: add label properties for UART,
 I2C, and SPI
In-Reply-To: <1449782473-20880-1-git-send-email-robh@kernel.org>
References: <1449782473-20880-1-git-send-email-robh@kernel.org>
Message-ID: <1449782473-20880-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add label properties to provide a way to identify UART, I2C and SPI
ports based on their connector names. This follows naming convention in
96boards CE spec. Ports without external connections are not labelled.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 7505fa3..14fafa1 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -28,6 +28,7 @@
 
 	soc {
 		serial at 78af000 {
+			label = "LS-UART0";
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart1_default>;
@@ -35,6 +36,7 @@
 		};
 
 		serial at 78b0000 {
+			label = "LS-UART1";
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart2_default>;
@@ -43,26 +45,31 @@
 
 		i2c at 78b6000 {
 		/* On Low speed expansion */
+			label = "LS-I2C0";
 			status = "okay";
 		};
 
 		i2c at 78b8000 {
 		/* On High speed expansion */
+			label = "HS-I2C2";
 			status = "okay";
 		};
 
 		i2c at 78ba000 {
 		/* On Low speed expansion */
+			label = "LS-I2C1";
 			status = "okay";
 		};
 
 		spi at 78b7000 {
 		/* On High speed expansion */
+			label = "HS-SPI1";
 			status = "okay";
 		};
 
 		spi at 78b9000 {
 		/* On Low speed expansion */
+			label = "LS-SPI0";
 			status = "okay";
 		};
 
-- 
2.5.0
