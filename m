From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Aug 2015 10:58:08 +0200
Subject: [PATCH v4 4/6] ARM: shmobile: sh73a0 dtsi: Add L1 cache information
 to CPU nodes
In-Reply-To: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438765090-823-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the L1 caches in the CPU nodes:
  - L1 instruction cache: 32 KiB (8 KiB x 4 ways) per CPU,
  - L1 data cache: 32 KiB (8 KiB x 4 ways) per CPU.

Add links to the L2 cache.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 arch/arm/boot/dts/sh73a0.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index e84fce5e4090f4ab..34f45023d1d29ed0 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -28,6 +28,15 @@
 			reg = <0>;
 			clock-frequency = <1196000000>;
 			power-domains = <&pd_a2sl>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <256>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
@@ -35,6 +44,15 @@
 			reg = <1>;
 			clock-frequency = <1196000000>;
 			power-domains = <&pd_a2sl>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <256>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2>;
 		};
 	};
 
-- 
1.9.1
