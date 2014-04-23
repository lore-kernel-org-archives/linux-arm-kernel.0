From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:31 +0900
Subject: [PATCH 03/33] ARM: shmobile: r8a7791/koelsch dts: Rename label spi to
 qspi, add spi0 alias
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <6f3e4ee340ea11d9aba39c5beaa80f0d3f368428.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Prepare for the advent of MSIOF SPI, which will be spi1 to spi3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi        | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index bdd73e6..bf9555b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -244,7 +244,7 @@
 		renesas,function = "sdhi2";
 	};
 
-	qspi_pins: spi {
+	qspi_pins: spi0 {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
@@ -301,7 +301,7 @@
 	status = "okay";
 };
 
-&spi {
+&qspi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 23ae96e..6cda188 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -27,6 +27,7 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		spi0 = &qspi;
 	};
 
 	cpus {
@@ -789,7 +790,7 @@
 		};
 	};
 
-	spi: spi at e6b10000 {
+	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.2
