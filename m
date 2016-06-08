From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:39 +0900
Subject: [PATCH 2/9] arm64: dts: r8a7795: Increase the size of GIC-400 mapped
 registers
In-Reply-To: <cover.1465347183.git.horms+renesas@verge.net.au>
References: <cover.1465347183.git.horms+renesas@verge.net.au>
Message-ID: <457f47b7651ccb1828c1d02f7ace0d07e9b16f33.1465347183.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>

There are some requirements about the GIC-400 memory layout and its
mapping if using 64k aligned base addresses like on r8a7795.

See e.g.

http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=21550029f709072aacf3b9

Map the whole memory range instead of only 0x2000. This will fix
the issue that some hypervisors, e.g. Xen, fail to handle the
interrupts correctly.

Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3285a9286786..de3e799a7bba 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -157,9 +157,9 @@
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0x0 0xf1010000 0 0x1000>,
-			      <0x0 0xf1020000 0 0x2000>,
+			      <0x0 0xf1020000 0 0x20000>,
 			      <0x0 0xf1040000 0 0x20000>,
-			      <0x0 0xf1060000 0 0x2000>;
+			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
-- 
2.1.4
