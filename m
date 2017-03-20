From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:49 +0100
Subject: [PATCH 10/31] ARM: dts: r8a7792: Remove unit-address and reg from
 integrated cache
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <a0504f0880c11da301dc2b5a5135bd02376e367e.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 8ecfda7a004e..c762f44f7732 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -60,9 +60,8 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller at 0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			cache-unified;
 			cache-level = <2>;
 			power-domains = <&sysc R8A7792_PD_CA15_SCU>;
-- 
2.7.0.rc3.207.g0ac5344
