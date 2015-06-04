From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  4 Jun 2015 20:53:31 +0200
Subject: [PATCH/RFC 05/15] ARM: shmobile: r8a7793 dtsi: Add L2
 cache-controller node
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1433444021-22167-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the L2 cache:
  - The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized
    as 64 KiB x 16 ways), and requires the following settings:
      - Tag RAM latency: 3 cycles,
      - Data RAM latency: 4 cycles,
      - Data RAM setup: 0 cycles.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for a Cortex-A15 L2 cache controller?
---
 arch/arm/boot/dts/r8a7793.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index f337634888de7800..cf153b9c2367a211 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -41,6 +41,19 @@
 		};
 	};
 
+	L2_CA15: cache-controller at 0 {
+		compatible = "cache";
+
+		arm,data-latency = <4 4 0>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x100000>;
+		cache-sets = <2048>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
