From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 14 Aug 2017 17:23:48 +0800
Subject: [PATCH v2] arm64: dts: hisi: add PCIe host controller node for hip07
 SoC
Message-ID: <1502702628-146770-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add one PCIe host controller node for HiSilicon Hip07 SoC and enable it in
D05 board.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
index f5d7f08..fe7c16c 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
@@ -84,3 +84,7 @@
 &sas1 {
 	status = "ok";
 };
+
+&p0_pcie2_a {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 283d7b5..2c01a21 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1534,5 +1534,27 @@
 				     <637 1>,<638 1>,<639 1>;
 			status = "disabled";
 		};
+
+		p0_pcie2_a: pcie at a00a0000 {
+			compatible = "hisilicon,hip07-pcie-ecam";
+			reg = <0 0xaf800000 0 0x800000>,
+			      <0 0xa00a0000 0 0x10000>;
+			bus-range = <0xf8 0xff>;
+			msi-map = <0xf800 &p0_its_dsa_a 0xf800 0x800>;
+			msi-map-mask = <0xffff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			ranges = <0x02000000 0 0xa8000000 0 0xa8000000 0 0x77f0000
+				  0x01000000 0 0 0 0xaf7f0000 0 0x10000>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <0x0 0 0 1 &mbigen_pcie2_a 671 4
+					 0x0 0 0 2 &mbigen_pcie2_a 671 4
+					 0x0 0 0 3 &mbigen_pcie2_a 671 4
+					 0x0 0 0 4 &mbigen_pcie2_a 671 4>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
