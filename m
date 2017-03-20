From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:31 +0100
Subject: [PATCH 20/32] arm64: dts: r8a7795: Remove unit-addresses and regs
 from integrated caches
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <d165856de103a6d317a9c9a5782eacd5dc90a9dc.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Cortex-A57/A53 cache controllers are integrated controllers, and
thus the device nodes representing them should not have unit-addresses
or reg properties.

Fixes: 6f7bf82cc912441f ("arm64: dts: r8a7795: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c1e00a3e7c45..14772bc02125 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -109,17 +109,15 @@
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
2.7.0.rc3.207.g0ac5344
