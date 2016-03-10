From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Thu, 10 Mar 2016 12:36:14 +0100
Subject: [PATCH 22/30] ARM: dts: r8a7793: Reference both DMA controllers in
 SCIF nodes
In-Reply-To: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1457609782-24108-23-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7793.dtsi | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 0242b97..506ef10 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -420,8 +420,9 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+		       <&dmac1 0x29>, <&dmac1 0x2a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -432,8 +433,9 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+		       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -444,8 +446,9 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+		       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -456,8 +459,9 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+		       <&dmac1 0x2f>, <&dmac1 0x30>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -468,8 +472,9 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+		       <&dmac1 0xfb>, <&dmac1 0xfc>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -480,8 +485,9 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
 		clock-names = "sci_ick";
-		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+		       <&dmac1 0xfd>, <&dmac1 0xfe>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.2
