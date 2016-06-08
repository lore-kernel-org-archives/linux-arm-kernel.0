From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:47 +0900
Subject: [PATCH 17/30] ARM: dts: r8a7794: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <34ea4b4a827b4ee76295501b7df61fc904ab8ae3.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property

Move the cache-controller node under the cpus node, and make its unit
name and reg property match the MPIDR value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index ad1df8317575..685f986cf962 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -55,13 +55,14 @@
 			power-domains = <&sysc R8A7794_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
 		};
-	};
 
-	L2_CA7: cache-controller at 1 {
-		compatible = "cache";
-		power-domains = <&sysc R8A7794_PD_CA7_SCU>;
-		cache-unified;
-		cache-level = <2>;
+		L2_CA7: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			power-domains = <&sysc R8A7794_PD_CA7_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
-- 
2.1.4
