From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 11:15:22 +0900
Subject: [PATCH 4/6] ARM: shmobile: r8a7791: enable Audio DMAC peri peri via
 sound driver
In-Reply-To: <cover.1426731062.git.horms+renesas@verge.net.au>
References: <cover.1426731062.git.horms+renesas@verge.net.au>
Message-ID: <d73a5013ed61bc605374f72ce879a358feba7f3e.1426731062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Audio DMAC peri peri is no longer DMAEngine. it is supported by
sound driver. this patch enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8631e02..a697b94 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -357,13 +357,6 @@
 		dma-channels = <13>;
 	};
 
-	audmapp: dma-controller at ec740000 {
-		compatible = "renesas,rcar-audmapp";
-		#dma-cells = <1>;
-
-		reg = <0 0xec740000 0 0x200>;
-	};
-
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
@@ -1503,8 +1496,9 @@
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x1280>; /* SSI */
-		reg-names = "scu", "adg", "ssiu", "ssi";
+			<0 0xec541000 0 0x1280>, /* SSI */
+			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7791_CLK_SSI9>, <&mstp10_clks R8A7791_CLK_SSI8>,
-- 
2.1.4
