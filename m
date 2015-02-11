From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Feb 2015 18:03:33 -0800
Subject: [PATCH] ARM: dts: BCM63xx: fix L2 cache properties
Message-ID: <1423620213-29785-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 cache properties were completely off with respect to what the
hardware is configured for. Fix the cache-size, cache-line-size and
cache-sets to reflect the L2 cache controller we have: 512KB, 16 ways
and 32 bytes per cache-line.

Fixes: 46d4bca0445a0 ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index d2d8e94e0aa2..f46329c8ad75 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -66,8 +66,9 @@
 			reg = <0x1d000 0x1000>;
 			cache-unified;
 			cache-level = <2>;
-			cache-sets = <16>;
-			cache-size = <0x80000>;
+			cache-size = <524288>;
+			cache-sets = <1024>;
+			cache-line-size = <32>;
 			interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.1.0
