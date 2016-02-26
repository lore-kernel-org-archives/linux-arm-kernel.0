From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:43 +0900
Subject: [PATCH 10/14] arm64: dts: r8a7795: use fallback etheravb
 compatibility string
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <2b953ccd0e11bc468ff7337c9ae66c97c7747396.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7795 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c2bffd160c18..e9adb31cd48c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -473,7 +473,8 @@
 		};
 
 		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7795";
+			compatible = "renesas,etheravb-r8a7795",
+				     "renesas,etheravb-rcar-gen3";
 			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.7.0.rc3.207.g0ac5344
