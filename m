From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Aug 2015 10:58:06 +0200
Subject: [PATCH v4 2/6] ARM: shmobile: r8a7740 dtsi: Add L1 cache information
 to CPU node
In-Reply-To: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438765090-823-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the L1 cache in the CPU node:
  - L1 instruction cache: 32 KiB (8 KiB x 4 ways),
  - L1 data cache: 32 KiB (8 KiB x 4 ways).

Add a link to the L2 cache.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,

v3:
  - No changes,

v2:
  - New.
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index ddef5b1c68fa06b3..3aaab195132bfc2c 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -26,6 +26,15 @@
 			reg = <0x0>;
 			clock-frequency = <800000000>;
 			power-domains = <&pd_a3sm>;
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
