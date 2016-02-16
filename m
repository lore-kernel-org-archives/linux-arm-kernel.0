From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 16 Feb 2016 10:43:22 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: Add GIC-400 virtual interfaces
Message-ID: <1455615802-9083-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
Changes in v2: Extend the GICH size to 128kB.

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8f1ed23..65f9cc8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -130,7 +130,9 @@
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
2.5.1
