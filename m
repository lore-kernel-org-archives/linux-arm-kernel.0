From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 14:33:03 +0200
Subject: [PATCH v3 02/10] ARM: dts: r8a7779: Use R-Car GPIO Gen1 fallback
 compat string
In-Reply-To: <20171013123311.15278-1-horms+renesas@verge.net.au>
References: <20171013123311.15278-1-horms+renesas@verge.net.au>
Message-ID: <20171013123311.15278-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen1 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in DT of r8a7779 SoC.

As the driver does not match on "renesas,gpio-r8a7779" there
are some run-time considerations for this patch:

* When a resulting DTB is used with kernels newer than v4.14 this should
  not have any run-time effect as renesas,rcar-gen1-gpio is matched by the
  driver since commit dbd1dad2ab8f ("gpio: rcar: add gen[123] fallback
  compatibility strings")

* However, when used with older kernels GPIO will be disabled as
  no compat string match will be made by the driver.

The regression documented above for the new DTB with old kernel case
is acceptable in my opinion.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3
* Consistently refer to gen1 rather than gen2 binding in changelog

v2
* Note run-time considerations in changelog as pointed out by
  Geert Uytterhoeven
---
 arch/arm/boot/dts/r8a7779.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 8ee0b2ca5d39..ccef2cfab6e0 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -76,7 +76,7 @@
 	};
 
 	gpio0: gpio at ffc40000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc40000 0x2c>;
 		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -87,7 +87,7 @@
 	};
 
 	gpio1: gpio at ffc41000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc41000 0x2c>;
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -98,7 +98,7 @@
 	};
 
 	gpio2: gpio at ffc42000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc42000 0x2c>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -109,7 +109,7 @@
 	};
 
 	gpio3: gpio at ffc43000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc43000 0x2c>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -120,7 +120,7 @@
 	};
 
 	gpio4: gpio at ffc44000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc44000 0x2c>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -131,7 +131,7 @@
 	};
 
 	gpio5: gpio at ffc45000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc45000 0x2c>;
 		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -142,7 +142,7 @@
 	};
 
 	gpio6: gpio at ffc46000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc46000 0x2c>;
 		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.11.0
