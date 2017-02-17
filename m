From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 16:30:34 +0100
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
References: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487345435-1088-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the Cortex-A53 L2 cache-controller.

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Extracted from a patch by Takeshi Kihara in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 6c0a65abf9fd09eb..d848e94d7282e5aa 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -62,6 +62,14 @@
 			cache-unified;
 			cache-level = <2>;
 		};
+
+		L2_CA53: cache-controller at 100 {
+			compatible = "cache";
+			reg = <0x100>;
+			power-domains = <&sysc R8A7796_PD_CA53_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	extal_clk: extal {
-- 
1.9.1
