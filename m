From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:37 +0100
Subject: [PATCH 26/32] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <a681e6d63285b879bb9bab0bd79e2021e6dcbda1.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Cortex-A53 L2 cache-controller.

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Extracted from a patch by Takeshi Kihara in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 454e1292f910..b951f5ffe9e0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -61,6 +61,13 @@
 			cache-unified;
 			cache-level = <2>;
 		};
+
+		L2_CA53: cache-controller-1 {
+			compatible = "cache";
+			power-domains = <&sysc R8A7796_PD_CA53_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	extal_clk: extal {
-- 
2.7.0.rc3.207.g0ac5344
