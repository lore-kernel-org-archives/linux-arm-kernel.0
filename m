From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:30 +0900
Subject: [PATCH 02/33] ARM: shmobile: r8a7790/lager dts: Rename label spi to
 qspi, add spi0 alias
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <fad6d45cdf8269d6d1c6784792c74c53e2304b32.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Prepare for the advent of MSIOF SPI, which will be spi1 to spi4.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 arch/arm/boot/dts/r8a7790.dtsi      | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..86dbdc1 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -155,7 +155,7 @@
 		renesas,function = "mmc1";
 	};
 
-	qspi_pins: spi {
+	qspi_pins: spi0 {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
@@ -190,7 +190,7 @@
 	status = "okay";
 };
 
-&spi {
+&qspi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 618e5b5..9383b84 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -24,6 +24,7 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		spi0 = &qspi;
 	};
 
 	cpus {
@@ -765,7 +766,7 @@
 		};
 	};
 
-	spi: spi at e6b10000 {
+	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.2
