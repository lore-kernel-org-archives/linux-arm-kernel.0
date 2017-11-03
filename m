From: xiaowei.bao@nxp.com (Bao Xiaowei)
Date: Fri, 3 Nov 2017 17:31:13 +0800
Subject: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
In-Reply-To: <20171103093115.14915-1-xiaowei.bao@nxp.com>
References: <20171103093115.14915-1-xiaowei.bao@nxp.com>
Message-ID: <20171103093115.14915-2-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the property of inbind and outbind windows number for ep
driver.

add the inband or outband window entry for pcie controller
ep driver used in dts.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
 v2:
 - no change

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06b5e12d04d8..f8332669663c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -674,6 +674,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <4>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -699,6 +701,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <2>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -724,6 +728,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <2>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-- 
2.14.1
