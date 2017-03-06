From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  6 Mar 2017 17:40:37 +0100
Subject: [PATCH 2/8] ARM: dts: r8a7743: Remove unit-address and reg from
 integrated cache
In-Reply-To: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
References: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488818443-25196-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 34e8d993a68ae459 ("ARM: dts: r8a7743: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0c44b9db4f34490f..0ddac81742e4cdc7 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -32,9 +32,8 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller at 0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			cache-unified;
 			cache-level = <2>;
 			power-domains = <&sysc R8A7743_PD_CA15_SCU>;
-- 
2.7.4
