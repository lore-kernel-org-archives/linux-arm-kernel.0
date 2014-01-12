From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:13:39 +0100
Subject: [PATCH V3 6/9] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389525222-3482-7-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - No changes
V3:
  - No changes

 arch/arm/boot/dts/r7s72100.dtsi |   65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index ff0bd6be454f..42e9b423476c 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -34,6 +34,11 @@
 		gpio10 = &port10;
 		gpio11 = &port11;
 		gpio12 = &jtagport0;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
 	};
 
 	cpus {
@@ -289,4 +294,64 @@
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
+
+	spi0: spi at e800c800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800c800 0x24>;
+		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi1: spi at e800d000 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800d000 0x24>;
+		interrupts = <0 241 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 242 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi2: spi at e800d800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800d800 0x24>;
+		interrupts = <0 244 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 245 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi3: spi at e800e000 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800e000 0x24>;
+		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 248 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi4: spi at e800e800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800e800 0x24>;
+		interrupts = <0 250 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 251 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5
