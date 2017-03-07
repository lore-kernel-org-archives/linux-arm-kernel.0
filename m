From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Mar 2017 19:03:24 +0100
Subject: [PATCH v2 3/5] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
References: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488909806-3322-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the Cortex-A53 L2 cache-controller.

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Extracted from a patch by Takeshi Kihara in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop unit address and reg property for integrated cache-controller.
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 454e1292f9108b34..b951f5ffe9e0faa0 100644
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
2.7.4
