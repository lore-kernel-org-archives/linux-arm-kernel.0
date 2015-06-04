From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  4 Jun 2015 20:53:35 +0200
Subject: [PATCH/RFC 09/15] ARM: shmobile: r8a7793 dtsi: Add L1 cache
 information to CPU node
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1433444021-22167-10-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the L1 instruction and data caches in the CPU node:
  - The L1 caches for the Cortex-A15 CPU cores are organized as 16 KiB x
    2 ways.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cf153b9c2367a211..a7e892fe3efa7fd3 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -38,6 +38,16 @@
 					   < 937500 1000000>,
 					   < 750000 1000000>,
 					   < 375000 1000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <512>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA15>;
 		};
 	};
 
-- 
1.9.1
