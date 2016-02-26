From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:38 +0900
Subject: [PATCH 05/14] arm64: dts: r8a7795: Add CA53 L2 cache-controller node
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <8e1c3aa30c2c3a5f982da9365a1ef03a3ac7a815.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Cortex-A53 L2 cache-controller.

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index ea56066c2260..e32b652c8fd0 100644
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
2.7.0.rc3.207.g0ac5344
