From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 18 May 2018 22:45:36 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add GEther support
In-Reply-To: <a4230699-e46f-0782-e3b1-22d58b9033c8@cogentembedded.com>
References: <a4230699-e46f-0782-e3b1-22d58b9033c8@cogentembedded.com>
Message-ID: <8910c197-cf1b-9ee9-9ddb-5d2f705a4b26@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77980 part of the GEther device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -417,6 +417,17 @@
 			dma-channels = <16>;
 		};
 
+		gether: ethernet at e7400000 {
+			compatible = "renesas,gether-r8a77980";
+			reg = <0 0xe7400000 0 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		mmc0: mmc at ee140000 {
 			compatible = "renesas,sdhi-r8a77980",
 				     "renesas,rcar-gen3-sdhi";
