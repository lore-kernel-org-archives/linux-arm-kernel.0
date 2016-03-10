From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Thu, 10 Mar 2016 12:36:12 +0100
Subject: [PATCH 20/30] ARM: dts: r8a7793: Reference both DMA controllers in
 SCIFB nodes
In-Reply-To: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1457609782-24108-21-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7793.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 322d290..445ab3a 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -381,8 +381,9 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -393,8 +394,9 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+		       <&dmac1 0x19>, <&dmac1 0x1a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -405,8 +407,9 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+		       <&dmac1 0x1d>, <&dmac1 0x1e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.2
