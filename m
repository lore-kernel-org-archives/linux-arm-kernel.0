From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:53 +0100
Subject: [PATCH v2 04/13] ARM: dts: db600c: add board support with serial
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-5-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to DB600c with basic serial ports.
DB600c is based on APQ8064.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts | 36 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..fef61b3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -539,6 +539,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
+	qcom-apq8064-arrow-db600c.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
 	qcom-apq8064-sony-xperia-yuga.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
new file mode 100644
index 0000000..57d4500
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -0,0 +1,36 @@
+#include "qcom-apq8064-v2.0.dtsi"
+
+/ {
+	model = "Arrow Electronics, APQ8064 DB600c";
+	compatible = "arrow,db600c", "qcom,apq8064";
+
+	aliases {
+		serial0 = &gsbi7_serial;
+		serial1 = &gsbi1_serial;
+	};
+
+	soc {
+		gsbi at 12440000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
+			serial at 12450000 {
+				label = "LS-UART1";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi1_uart_4pins>;
+			};
+		};
+
+		/* DEBUG UART  */
+		gsbi at 16600000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial at 16640000 {
+				label = "LS-UART0";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi7_uart_2pins>;
+			};
+		};
+	};
+};
-- 
2.5.0
