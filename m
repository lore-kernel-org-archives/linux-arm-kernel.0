From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:51 -0600
Subject: [PATCH 03/13] dtb: amd: Fix DMA ranges in device tree
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-4-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Fix DMA ranges of smb0 and pcie0 nodes in AMD Seattle SOC.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index fdd0c96..5c73117 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -55,8 +55,12 @@
 		#size-cells = <2>;
 		ranges;
 
-		/* DDR range is 40-bit addressing */
-		dma-ranges = <0x80 0x0 0x80 0x0 0x7f 0xffffffff>;
+		/*
+		 * dma-ranges is 40-bit address space containing:
+		 * - GICv2m MSI register is at 0xe0080000
+		 * - DRAM range [0x8000000000 to 0xffffffffff]
+		 */
+		dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x0>;
 
 		/include/ "amd-seattle-clks.dtsi"
 
@@ -159,7 +163,7 @@
 				<0x1000 0x0 0x0 0x4 &gic0 0x0 0x0 0x0 0x123 0x1>;
 
 			dma-coherent;
-			dma-ranges = <0x43000000 0x80 0x0 0x80 0x0 0x7f 0xffffffff>;
+			dma-ranges = <0x43000000 0x0 0x0 0x0 0x0 0x100 0x0>;
 			ranges =
 				/* I/O Memory (size=64K) */
 				<0x01000000 0x00 0x00000000 0x00 0xefff0000 0x00 0x00010000>,
-- 
2.5.0
