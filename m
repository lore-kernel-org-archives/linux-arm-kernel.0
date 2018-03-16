From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:15 +0100
Subject: [PATCH 45/69] arm64: dts: renesas: r8a77965: Remove stale reg property
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <217a7d465b120f3227df592a12bbee9bac165613.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Remove "reg" property from cache-controller-0 device node as it does not
have any unit address.

This silences the following DTC compiler warning:
Warning (unit_address_vs_reg): Node /cpus/cache-controller-0 has a reg
or ranges property, but no unit name

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 61efb2d22257..0536b94a5ec0 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -47,7 +47,6 @@
 
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc 12>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.11.0
