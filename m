From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Sun, 30 Nov 2014 21:46:39 -0600
Subject: [PATCH 1/2] arm64: amd-seattle: Fix dma-ranges property
In-Reply-To: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1417405600-19232-2-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

AMD Seattle should support 40-bit DMA.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 0c8e7ae..f370f03 100644
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
1.9.3
