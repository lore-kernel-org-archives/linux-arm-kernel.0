From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:19 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Fix SD2CKCR register address
In-Reply-To: <cover.1406162627.git.horms+renesas@verge.net.au>
References: <cover.1406162627.git.horms+renesas@verge.net.au>
Message-ID: <c9b227723d051184b9e78f20c75ae2f9d44a6ea2.1406162627.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

59e79895b95892863617ce630fbda467f2470575
(ARM: shmobile: r8a7791: Add clocks)
added r8a7791 SD clocks when v3.14.

2c60a7df72711fb8b4be1e6aa651ab166a8931bc
(ARM: shmobile: Add SDHI devices for Koelsch DTS)
enabled SD on r8a7791 Koelsch when v3.15.

1299df03d7191ab4356c995dde8b912d3c8922e9
(ARM: shmobile: henninger: add SDHI0/2 DT support)
enable SD on r8a7791 Henninger when v3.16.

But r8a7791 SD clock had wrong address.
This patch fixup it.

[Kuninori Morimoto: tidyup for upstreaming]

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8d7ffae..79f68ac 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -540,9 +540,9 @@
 			#clock-cells = <0>;
 			clock-output-names = "sd1";
 		};
-		sd2_clk: sd3_clk at e615007c {
+		sd2_clk: sd3_clk at e615026c {
 			compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615007c 0 4>;
+			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sd2";
-- 
2.0.1
