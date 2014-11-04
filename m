From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:51:01 +0900
Subject: [PATCH 31/34] ARM: shmobile: r8a7791: Add MMCIF0 DT node
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <8edae499162c30af16f0b8a77d394c19791ae372.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the MMCIF0 device to the r8a7791 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index c815313..8459fe6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -400,6 +400,15 @@
 		#gpio-range-cells = <3>;
 	};
 
+	mmcif0: mmc at ee200000 {
+		compatible = "renesas,mmcif-r8a7791", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee100000 0 0x200>;
-- 
2.1.1
