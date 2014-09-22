From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:24 +0200
Subject: [PATCH 3/9] ARM: dts: vf610: add on-chip SRAM
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <593e881b5050795076426a4071bfa1bff66cb215.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67bb3b7..d2128e5 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -69,6 +69,27 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		ocram0: sram at 3f000000 {
+			compatible = "mmio-sram";
+			reg = <0x3f000000 0x40000>;
+		};
+
+		ocram1: sram at 3f040000 {
+			compatible = "mmio-sram";
+			reg = <0x3f040000 0x40000>;
+		};
+
+		gfxram0: sram at 3f400000 {
+			compatible = "mmio-sram";
+			reg = <0x3f400000 0x80000>;
+		};
+
+		/* used by L2 cache */
+		gfxram1: sram at 3f480000 {
+			compatible = "mmio-sram";
+			reg = <0x3f480000 0x80000>;
+		};
+
 		aips0: aips-bus at 40000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.1.0
