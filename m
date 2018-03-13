From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2018 13:13:09 +0100
Subject: [PATCH] arm64: dts: qcom: rename qcom,pcie devices to pcie
Message-ID: <20180313121345.2749183-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node name for a PCIe host bridge must be "pcie" as required by
the binging. dtc now warns about it:

arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_bridge): /soc/agnoc at 0/qcom,pcie at 610000: node name is not "pci" or "pcie"
arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_bridge): /soc/agnoc at 0/qcom,pcie at 610000: node name is not "pci" or "pcie"
arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

This renames the nodes as appropriate.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1c8f1b86472d..e82f821a4e0e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -140,16 +140,16 @@
 		};
 
 		agnoc at 0 {
-			qcom,pcie at 600000 {
+			pcie at 600000 {
 				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
 			};
 
-			qcom,pcie at 608000 {
+			pcie at 608000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
 			};
 
-			qcom,pcie at 610000 {
+			pcie at 610000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
 			};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 410ae787ebb4..cd08c8c5248e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -851,7 +851,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			pcie0: qcom,pcie at 600000 {
+			pcie0: pcie at 600000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				status = "disabled";
 				power-domains = <&gcc PCIE0_GDSC>;
@@ -904,7 +904,7 @@
 
 			};
 
-			pcie1: qcom,pcie at 608000 {
+			pcie1: pcie at 608000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				power-domains = <&gcc PCIE1_GDSC>;
 				bus-range = <0x00 0xff>;
@@ -957,7 +957,7 @@
 						"bus_slave";
 			};
 
-			pcie2: qcom,pcie at 610000 {
+			pcie2: pcie at 610000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				power-domains = <&gcc PCIE2_GDSC>;
 				bus-range = <0x00 0xff>;
-- 
2.9.0
