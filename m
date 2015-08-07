From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:11:27 +0900
Subject: [PATCH 03/10] ARM: shmobile: r8a7794: add PFC DT support
In-Reply-To: <cover.1438911334.git.horms+renesas@verge.net.au>
References: <cover.1438911334.git.horms+renesas@verge.net.au>
Message-ID: <fd1683c18c372d51aeeeb25efa8b451f922c9c52.1438911334.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7794 part of the PFC device node.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8824dbd5dbb4..51cc2b975c3f 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -108,6 +108,12 @@
 		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
 	};
 
+	pfc: pin-controller at e6060000 {
+		compatible = "renesas,pfc-r8a7794";
+		reg = <0 0xe6060000 0 0x11c>;
+		#gpio-range-cells = <3>;
+	};
+
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
-- 
2.1.4
