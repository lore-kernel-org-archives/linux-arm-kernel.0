From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 22 Oct 2015 11:13:50 -0700
Subject: [PATCH 3/4] ARM: dts: qcom: apq8064: Introduce gsbi5 and gsbi5 serial
 node
In-Reply-To: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445537631-29055-4-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1bc6c4039dea..fa3053c14532 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -320,6 +320,28 @@
 			};
 		};
 
+		gsbi5: gsbi at 1a200000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <5>;
+			reg = <0x1a200000 0x03>;
+			clocks = <&gcc GSBI5_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gsbi5_serial: serial at 1a240000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x1a240000 0x100>,
+				      <0x1a200000 0x03>;
+				interrupts = <0 154 0x0>;
+				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+		};
+
 		gsbi6: gsbi at 16500000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.4.2
