From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:11:26 +0900
Subject: [PATCH 02/10] ARM: shmobile: r8a7791: Add JPU device node.
In-Reply-To: <cover.1438911334.git.horms+renesas@verge.net.au>
References: <cover.1438911334.git.horms+renesas@verge.net.au>
Message-ID: <0caa36603300dd4ff4841227cf372e91e940c8bd.1438911334.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

This patch contains device tree node definition for JPEG codec peripheral
found in the Renesas R-Car r8a7791 SoC.

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d37339bd7cdb..1cb6c2d07933 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -898,6 +898,13 @@
 		status = "disabled";
 	};
 
+	jpu: jpeg-codec at fe980000 {
+		compatible = "renesas,jpu-r8a7791";
+		reg = <0 0xfe980000 0 0x10300>;
+		interrupts = <0 272 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_JPU>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
