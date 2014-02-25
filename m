From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Feb 2014 11:30:14 +0100
Subject: [PATCH v2 06/11] ARM: shmobile: r8a7791/koelsch dts: Rename label spi
 to qspi, add spi0 alias
In-Reply-To: <1393324219-3317-1-git-send-email-geert@linux-m68k.org>
References: <1393324219-3317-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1393324219-3317-7-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Prepare for the advent of MSIOF SPI, which will be spi1 to spi3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree at vger.kernel.org
---
v2:
  - No changes

 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++--
 arch/arm/boot/dts/r8a7791.dtsi        |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 603af8caae5b..03508cc73e8b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -157,7 +157,7 @@
 		renesas,function = "intc";
 	};
 
-	qspi_pins: spi {
+	qspi_pins: spi0 {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
@@ -182,7 +182,7 @@
 	status = "okay";
 };
 
-&spi {
+&qspi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index cde7bc486f22..3bc4546fa9c5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -27,6 +27,7 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		spi0 = &qspi;
 	};
 
 	cpus {
@@ -762,7 +763,7 @@
 		};
 	};
 
-	spi: spi at e6b10000 {
+	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5
