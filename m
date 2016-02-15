From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 21:38:35 +0100
Subject: [PATCH v3 7/7] arm64: dts: r8a7795: Add CA53 L2 cache-controller node
In-Reply-To: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455568715-20880-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the Cortex-A53 L2 cache-controller.

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Remaining part of "[PATCH v2 6/6] arm64: renesas: r8a7795: Add L2
    cache-controller nodes".
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c07f4e83b988ba42..c572527afec3403a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -72,6 +72,12 @@
 		cache-level = <2>;
 	};
 
+	L2_CA53: cache-controller at 1 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.9.1
