From: Yuantian.Tang@freescale.com (Yuantian.Tang at freescale.com)
Date: Wed, 2 Dec 2015 15:16:31 +0800
Subject: [PATCH v3] ARM: dts: ls1021a: add sata node to dts
Message-ID: <1449040591-13618-1-git-send-email-Yuantian.Tang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Added sata node to ls1021aqds and ls1021atwr board to support
sata function.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v3:
	- refine the title and commit message
	- added a status property so that sata can be controlled
	by board specific dts.
v2:
	- put reg-names right after reg property

 arch/arm/boot/dts/ls1021a-qds.dts |  4 ++++
 arch/arm/boot/dts/ls1021a-twr.dts |  4 ++++
 arch/arm/boot/dts/ls1021a.dtsi    | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 0521e68..803cc54 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -327,3 +327,7 @@
 &uart1 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index fbb89d1..62dec7c 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -219,3 +219,7 @@
 &uart1 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9430a99..da9bd7e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -143,6 +143,17 @@
 			status = "disabled";
 		};
 
+		sata: sata at 3200000 {
+			compatible = "fsl,ls1021a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			      <0x0 0x20220520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
