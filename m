From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:37 +0900
Subject: [PATCH 04/14] arm64: dts: r8a7795: Add missing properties to CA57 L2
 cache node
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <a528b4bf1a2ecb756aa65548fd5518fe82fb4648.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the missing "cache-unified" and "cache-level" properties to the
Cortex-A57 cache-controller node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 832a5665bb27..ea56066c2260 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -68,6 +68,8 @@
 
 	L2_CA57: cache-controller at 0 {
 		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
 	};
 
 	extal_clk: extal {
-- 
2.7.0.rc3.207.g0ac5344
