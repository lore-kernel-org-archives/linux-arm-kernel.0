From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  4 Aug 2017 17:32:32 +0200
Subject: [PATCH v2] ARM64: dts: marvell: add NAND support on the CP110
Message-ID: <20170804153232.10686-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller used in A7K/A8K is present on the CP110. It is
compatible with the pxa-nand driver.

However, due to the limiation of the pins available this controller is
only usable on the CPM for A7K and on the CPS for A8K.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 5586a732e1be..8b019a9f4f59 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -249,6 +249,21 @@
 				status = "disabled";
 			};
 
+			cpm_nand: nand at 720000 {
+				/*
+				 * Due to the limiation of the pin available
+				 * this controller is only usable on the CPM
+				 * for A7K and on the CPS for A8K.
+				 */
+				compatible = "marvell,armada370-nand";
+				reg = <0x720000 0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cpm_clk 1 2>;
+				status = "disabled";
+			};
+
 			cpm_trng: trng at 760000 {
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 4be43f1f5aa2..7c1100133731 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -250,6 +250,21 @@
 				status = "disabled";
 			};
 
+			cps_nand: nand at 720000 {
+				/*
+				 * Due to the limiation of the pin available
+				 * this controller is only usable on the CPM
+				 * for A7K and on the CPS for A8K.
+				 */
+				compatible = "marvell,armada370-nand";
+				reg = <0x720000 0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_clk 1 2>;
+				status = "disabled";
+			};
+
 			cps_trng: trng at 760000 {
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
-- 
2.13.2
