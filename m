From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:11 +0200
Subject: [PATCH 3/7] ARM64: zynqmp: Add SMMU support
In-Reply-To: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
Message-ID: <014e41d9e1ba7ae406d463f75dfa236857192560.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SMMU DT node to DTSI.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index d58c9689c82a..7617722cc969 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -244,6 +244,18 @@
 			#size-cells = <0>;
 		};
 
+		smmu0: smmu0 at fd800000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0xfd800000 0x20000>;
+			#global-interrupts = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 157 4>,
+				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
+				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
+				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
+				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>;
+		};
+
 		spi0: spi at ff040000 {
 			compatible = "cdns,spi-r1p6";
 			status = "disabled";
-- 
2.3.5
