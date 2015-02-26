From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:29 +0900
Subject: [PATCH 32/32] ARM: shmobile: r8a7794: add SDHI DT support
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <b8e8ea127d00f1b0c18d8c1ae1b8388e190d5052.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7794 parts of the SDHI[012] device nodes.

Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index fff9497..7a3ffa5 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -340,6 +340,30 @@
 		status = "disabled";
 	};
 
+	sdhi0: sd at ee100000 {
+		compatible = "renesas,sdhi-r8a7794";
+		reg = <0 0xee100000 0 0x200>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
+		status = "disabled";
+	};
+
+	sdhi1: sd at ee140000 {
+		compatible = "renesas,sdhi-r8a7794";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
+		status = "disabled";
+	};
+
+	sdhi2: sd at ee160000 {
+		compatible = "renesas,sdhi-r8a7794";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
