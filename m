From: mikhail.ulyanov@cogentembedded.com (Mikhail Ulyanov)
Date: Fri, 24 Jul 2015 16:25:46 +0300
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Add JPU device node.
In-Reply-To: <1437744346-499-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
References: <1437744346-499-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
Message-ID: <1437744346-499-3-git-send-email-mikhail.ulyanov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains device tree node definition for JPEG codec peripheral
found in the Renesas R-Car r8a7791 SoC.

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 07ea2be..05eb7e3 100644
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
