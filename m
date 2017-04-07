From: xuwei5@hisilicon.com (Wei.Xu)
Date: Fri, 7 Apr 2017 10:07:52 +0800
Subject: [PATCH 1/5] arm64: dts: hisi: add mbigen nodes for the hip07 SoC
In-Reply-To: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
References: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <1491530876-109791-2-git-send-email-xuwei5@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Xu <xuwei5@hisilicon.com>

Add mbigen nodes for the hip07 SoC those will be used
for the SAS, XGE and PCIe host controllers.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 5144eb1..6077def 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1014,6 +1014,34 @@
 		compatible = "hisilicon,mbigen-v2";
 		reg = <0x0 0xa0080000 0x0 0x10000>;
 
+		mbigen_pcie2_a: intc_pcie2_a {
+			msi-parent = <&p0_its_dsa_a 0x40087>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <10>;
+		};
+
+		mbigen_sas1: intc_sas1 {
+			msi-parent = <&p0_its_dsa_a 0x40000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
+
+		mbigen_sas2: intc_sas2 {
+			msi-parent = <&p0_its_dsa_a 0x40040>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
+
+		mbigen_smmu_pcie: intc_smmu_pcie {
+			msi-parent = <&p0_its_dsa_a 0x40b0c>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <3>;
+		};
+
 		mbigen_usb: intc_usb {
 			msi-parent = <&p0_its_dsa_a 0x40080>;
 			interrupt-controller;
@@ -1022,6 +1050,39 @@
 		};
 	};
 
+	p0_mbigen_dsa_a: interrupt-controller at c0080000 {
+		compatible = "hisilicon,mbigen-v2";
+		reg = <0x0 0xc0080000 0x0 0x10000>;
+
+		mbigen_dsaf0: intc_dsaf0 {
+			msi-parent = <&p0_its_dsa_a 0x40800>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <409>;
+		};
+
+		mbigen_dsa_roce: intc-roce {
+			msi-parent = <&p0_its_dsa_a 0x40B1E>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <34>;
+		};
+
+		mbigen_sas0: intc-sas0 {
+			msi-parent = <&p0_its_dsa_a 0x40900>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <128>;
+		};
+
+		mbigen_smmu_dsa: intc_smmu_dsa {
+			msi-parent = <&p0_its_dsa_a 0x40b20>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <3>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1
