From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  6 Mar 2017 17:40:38 +0100
Subject: [PATCH 3/8] ARM: dts: r8a7745: Remove unit-address and reg from
 integrated cache
In-Reply-To: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
References: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488818443-25196-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A7 cache controller is an integrated controller, and thus the
device node representing it should not have a unit-addresses or reg
property.

Fixes: c95360247bdd67d3 ("ARM: dts: r8a7745: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7745.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index dcac70fbc4028c11..2feb0084bb3b1b51 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -32,9 +32,8 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		L2_CA7: cache-controller at 0 {
+		L2_CA7: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			cache-unified;
 			cache-level = <2>;
 			power-domains = <&sysc R8A7745_PD_CA7_SCU>;
-- 
2.7.4
