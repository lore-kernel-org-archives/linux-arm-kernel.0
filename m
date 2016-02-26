From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:40 +0900
Subject: [PATCH 07/14] arm64: dts: r8a7795: Add GIC-400 virtual interfaces
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <4c811edf65e809e6ac6ec35f4818efba2b1c6163.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Besides the distributor and the CPU interface the GIC-400 additionally
supports the virtual interface control blocks and the virtual CPU interfaces.

Add the physical base addresses and size for these.

See

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/index.html
-> 3.2. GIC-400 register map

and Linux kernel's

Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt

for more details.

For the at GICH Virtual interface control blocks at 0xf1040000 cover the
whole 128kB (0x20000) range. This is done based on the advice from Marc
Zyngier http://www.spinics.net/lists/arm-kernel/msg483139.html

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 6da8f79f10df..1072c681f8b4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -137,7 +137,9 @@
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0x0 0xf1010000 0 0x1000>,
-			      <0x0 0xf1020000 0 0x2000>;
+			      <0x0 0xf1020000 0 0x2000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x2000>;
 			interrupts = <GIC_PPI 9
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
-- 
2.7.0.rc3.207.g0ac5344
