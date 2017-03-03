From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Mar 2017 14:18:17 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7796: Remove unit-address and reg from
 integrated cache
In-Reply-To: <1488547097-4804-1-git-send-email-geert+renesas@glider.be>
References: <1488547097-4804-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488547097-4804-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A57 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 1561f20760ec96db ("arm64: dts: r8a7796: Add Renesas R8A7796 SoC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index f02dfdce92406f67..b950dcec9ace96a1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -48,9 +48,8 @@
 			enable-method = "psci";
 		};
 
-		L2_CA57: cache-controller at 0 {
+		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7796_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.7.4
