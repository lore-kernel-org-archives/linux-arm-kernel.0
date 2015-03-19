From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 11:15:21 +0900
Subject: [PATCH 3/6] ARM: shmobile: r8a7790: enable Audio DMAC peri peri via
 sound driver
In-Reply-To: <cover.1426731062.git.horms+renesas@verge.net.au>
References: <cover.1426731062.git.horms+renesas@verge.net.au>
Message-ID: <0c60267702244b8a6e62743a8e13a07823efbf6d.1426731062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Audio DMAC peri peri is no longer DMAEngine. it is supported by
sound driver. this patch enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2041ec7..48d11e0e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -370,13 +370,6 @@
 		dma-channels = <13>;
 	};
 
-	audmapp: dma-controller at ec740000 {
-		compatible = "renesas,rcar-audmapp";
-		#dma-cells = <1>;
-
-		reg = <0 0xec740000 0 0x200>;
-	};
-
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1460,8 +1453,9 @@
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x1280>; /* SSI */
-		reg-names = "scu", "adg", "ssiu", "ssi";
+			<0 0xec541000 0 0x1280>, /* SSI */
+			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
-- 
2.1.4
