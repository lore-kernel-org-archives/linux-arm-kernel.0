From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  6 Mar 2017 17:40:39 +0100
Subject: [PATCH 4/8] ARM: dts: r8a7790: Remove unit-addresses and regs from
 integrated caches
In-Reply-To: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
References: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488818443-25196-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A15/A7 cache controllers are integrated controllers, and thus
the device nodes representing them should not have unit-addresses or reg
properties.

Fixes: 2c3de36700d4f3a5 ("ARM: dts: r8a7790: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6d10450de6d7b97f..20cf191e0852b10a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -129,17 +129,15 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		L2_CA15: cache-controller at 0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7790_PD_CA15_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
-		L2_CA7: cache-controller at 100 {
+		L2_CA7: cache-controller-1 {
 			compatible = "cache";
-			reg = <0x100>;
 			power-domains = <&sysc R8A7790_PD_CA7_SCU>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.7.4
