From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 14:33:02 +0200
Subject: [PATCH v3 01/10] ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback
 compat string
In-Reply-To: <20171013123311.15278-1-horms+renesas@verge.net.au>
References: <20171013123311.15278-1-horms+renesas@verge.net.au>
Message-ID: <20171013123311.15278-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen1 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in DT of r8a7778 SoC.

As the driver does not match on "renesas,gpio-r8a7778" there
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
---
v3
* Consistently use gen1 rather than gen2 binding in patch and refer to it
  in changelog.

v2
* Note run-time considerations in changelog as pointed out by
  Geert Uytterhoeven

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 8f3156c0e575..a31817b2dda7 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -88,7 +88,7 @@
 	};
 
 	gpio0: gpio at ffc40000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc40000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -99,7 +99,7 @@
 	};
 
 	gpio1: gpio at ffc41000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc41000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -110,7 +110,7 @@
 	};
 
 	gpio2: gpio at ffc42000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc42000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -121,7 +121,7 @@
 	};
 
 	gpio3: gpio at ffc43000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc43000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -132,7 +132,7 @@
 	};
 
 	gpio4: gpio at ffc44000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc44000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.11.0
