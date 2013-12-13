From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:20 +0900
Subject: [PATCH 46/69] ARM: shmobile: Add r8a7791 thermal device node to DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <d103f4d3152b187b22fd6010370fe1d16419a334.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up the r8a7791 thermal sensor to the DTS.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d85254c..e36b3652 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -145,6 +145,13 @@
 		interrupt-controller;
 	};
 
+	thermal at e61f0000 {
+		compatible = "renesas,thermal-r8a7791", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
1.8.4
