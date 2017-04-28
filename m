From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Fri, 28 Apr 2017 12:10:36 +0200
Subject: [PATCH] arm: dts: qcom: add gsbi7 serial to ipq8064 SoC device tree
Message-ID: <20170428101036.8605-1-sven.eckelmann@openmesh.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gsbi_serial7 under gsbi7 is used by the IPQ8068 based board EWS870AP as
main serial console.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 76f4e8921d58..f1fbffe59b93 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -284,6 +284,29 @@
 			};
 		};
 
+		gsbi7: gsbi at 16600000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <7>;
+			reg = <0x16600000 0x100>;
+			clocks = <&gcc GSBI7_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			syscon-tcsr = <&tcsr>;
+
+			gsbi7_serial: serial at 16640000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x16640000 0x1000>,
+				      <0x16600000 0x1000>;
+				interrupts = <0 158 0x0>;
+				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+		};
+
 		sata_phy: sata-phy at 1b400000 {
 			compatible = "qcom,ipq806x-sata-phy";
 			reg = <0x1b400000 0x200>;
-- 
2.11.0
