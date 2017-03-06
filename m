From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  6 Mar 2017 17:40:36 +0100
Subject: [PATCH 1/8] ARM: dts: r8a73a4: Remove unit-addresses and regs from
 integrated caches
In-Reply-To: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
References: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488818443-25196-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A15/A7 cache controllers are integrated controllers, and thus
the device nodes representing them should not have unit-addresses or reg
properties.

Fixes: b0da45c60d2f7b08 ("ARM: dts: r8a73a4: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 00eb9a7114dc2621..6fb7eaba91262edf 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -32,18 +32,16 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller at 0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			clocks = <&cpg_clocks R8A73A4_CLK_Z>;
 			power-domains = <&pd_a3sm>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
-		L2_CA7: cache-controller at 100 {
+		L2_CA7: cache-controller-1 {
 			compatible = "cache";
-			reg = <0x100>;
 			clocks = <&cpg_clocks R8A73A4_CLK_Z2>;
 			power-domains = <&pd_a3km>;
 			cache-unified;
-- 
2.7.4
