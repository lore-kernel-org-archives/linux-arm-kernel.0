From: tanhuazhong@huawei.com (Huazhong Tan)
Date: Thu, 18 Jan 2018 20:31:37 +0800
Subject: [PATCH] arm64: dts: hisi: add hns-dsaf cpld control for the hip07 SoC
Message-ID: <1516278697-244377-1-git-send-email-tanhuazhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpld-syscon node to support the cpld control for hns-dsaf
on the hip07 SoC.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 2c01a21..4bd6416 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1127,6 +1127,12 @@
 			reg = <0x0 0xc0000000 0x0 0x10000>;
 		};
 
+		dsa_cpld: dsa_cpld at 78000010 {
+			compatible = "syscon";
+			reg = <0x0 0x78000010 0x0 0x100>;
+			reg-io-width = <2>;
+		};
+
 		pcie_subctl: pcie_subctl at a0000000 {
 			compatible = "hisilicon,pcie-sas-subctrl", "syscon";
 			reg = <0x0 0xa0000000 0x0 0x10000>;
@@ -1258,6 +1264,7 @@
 			port at 0 {
 				reg = <0>;
 				serdes-syscon = <&serdes_ctrl>;
+				cpld-syscon = <&dsa_cpld 0x0>;
 				port-rst-offset = <0>;
 				port-mode-offset = <0>;
 				mc-mac-mask = [ff f0 00 00 00 00];
@@ -1267,6 +1274,7 @@
 			port at 1 {
 				reg = <1>;
 				serdes-syscon= <&serdes_ctrl>;
+				cpld-syscon = <&dsa_cpld 0x4>;
 				port-rst-offset = <1>;
 				port-mode-offset = <1>;
 				mc-mac-mask = [ff f0 00 00 00 00];
-- 
1.9.1
