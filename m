From: Yuantian.Tang@freescale.com (Yuantian.Tang at freescale.com)
Date: Mon, 30 Nov 2015 11:39:35 +0800
Subject: [PATCH v2] ARM: DTS: LS1021A: add SATA node to DTS
Message-ID: <1448854775-19865-1-git-send-email-Yuantian.Tang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Added SATA node to LS1021A DTS to support SATA function.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- put reg-names right after reg property

 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9430a99..33aae8d 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -143,6 +143,16 @@
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
+		};
+
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
