From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:13 -0500
Subject: [PATCH 15/15] arm64: dts: xilinx: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-15-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 54dc28351c8c..1a3f5e928bb9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -221,6 +221,7 @@
 				  0x43000000 0x00000006 0x00000000 0x00000006
 				  0x00000000 0x00000002 0x00000000>;
 				  /* prefetchable memory */
+			bus-range = <0x00 0xff>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
-- 
2.10.1
