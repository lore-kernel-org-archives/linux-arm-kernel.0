From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:06 +0900
Subject: [PATCH 06/16] ARM: shmobile: r8a7778: add internal ethernet
 controller to DT
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <05cabb839e87a69f94d1e97fd2300b70f688122b.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Internal Ethernet controller DT entry with clock information.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 5c347e8..c802e72 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -41,6 +41,17 @@
 		spi2 = &hspi2;
 	};
 
+	ether: ethernet at fde00000 {
+		compatible = "renesas,ether-r8a7778";
+		reg = <0xfde00000 0x400>;
+		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
+		phy-mode = "rmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at fe438000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
2.1.4
