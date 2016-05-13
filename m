From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:48 +0200
Subject: [PATCH 08/23] ARM: dts: r8a7794: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property

Move the cache-controller node under the cpus node, and make its unit
name and reg property match the MPIDR value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f334a3a715f27d12..cff1c5aa0ec48950 100644
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
1.9.1
