From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Mar 2017 14:18:16 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7795: Remove unit-addresses and regs from
 integrated caches
In-Reply-To: <1488547097-4804-1-git-send-email-geert+renesas@glider.be>
References: <1488547097-4804-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488547097-4804-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A57/A53 cache controllers are integrated controllers, and
thus the device nodes representing them should not have unit-addresses
or reg properties.

Fixes: 6f7bf82cc912441f ("arm64: dts: r8a7795: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 13833aa8e035be04..67a8d2a4c9b568cc 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -110,17 +110,15 @@
 			enable-method = "psci";
 		};
 
-		L2_CA57: cache-controller at 0 {
+		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7795_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
-		L2_CA53: cache-controller at 100 {
+		L2_CA53: cache-controller-1 {
 			compatible = "cache";
-			reg = <0x100>;
 			power-domains = <&sysc R8A7795_PD_CA53_SCU>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.7.4
