From: Gang.Liu@nxp.com (Liu Gang)
Date: Tue, 7 Jun 2016 14:55:46 +0800
Subject: [PATCH] arm64: dts: ls1043a: Add 'dma-coherent' for ls1043a PCI nodes
In-Reply-To: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
References: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <1465282546-28256-2-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'dma-coherent' indicates that the hardware IP block can ensure
the coherency of the data transferred from/to the IP block. This
can avoid the software cache flush/invalid actions, and improve
the performance significantly.

The PCI IP block of ls1043a has this capability, so adding this
feature to improve the PCI performance.

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index de0323b..21a30f7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -479,6 +479,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			dma-coherent;
 			num-lanes = <4>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -503,6 +504,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			dma-coherent;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -527,6 +529,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			dma-coherent;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
-- 
2.1.0.27.g96db324
