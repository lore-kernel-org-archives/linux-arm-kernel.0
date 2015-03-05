From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:08 +0900
Subject: [PATCH 08/16] ARM: shmobile: r8a7778 dtsi: Add Bus State Controller
 node
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <d4578204e7af962c70a649ce2a46dc6fbe137db6.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Add a node for the Bus State Controller (BSC) on r8a7778, to which
multiple external devices can be connected.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index c802e72..5d486b9 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -41,6 +41,13 @@
 		spi2 = &hspi2;
 	};
 
+	bsc: bus at 1c000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x1c000000>;
+	};
+
 	ether: ethernet at fde00000 {
 		compatible = "renesas,ether-r8a7778";
 		reg = <0xfde00000 0x400>;
-- 
2.1.4
