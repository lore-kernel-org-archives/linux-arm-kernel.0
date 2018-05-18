From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:15 +0200
Subject: [PATCH 053/102] arm64: dts: renesas: r8a77990: Revise the cache
 controller node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <de1eb23c6d0f08f6a2eff99afe29b08f023e392d.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The cache controller node should not have unit-addresses and reg
properties. So, this patch removes them.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 19c1f7cea913..46580290b7fb 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -27,9 +27,8 @@
 			enable-method = "psci";
 		};
 
-		L2_CA53: cache-controller at 0 {
+		L2_CA53: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc 21>;
 			cache-unified;
 			cache-level = <2>;
-- 
2.11.0
