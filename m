From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:34 +0900
Subject: [PATCH 06/33] ARM: shmobile: lager dts: Add MSIOF nodes
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <b0403b91e18c567fe68976253ed5759c50fb3eae.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add pinctrl and SPI device for MSIOF on Lager.
On this board, only MSIOF1 is in use. Its bus contains a single device
(a Renesas R2A11302FT PMIC), for which no bindings are defined yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 86dbdc1..cdec1af 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -159,6 +159,12 @@
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
+
+	msiof1_pins: spi2 {
+		renesas,groups = "msiof1_clk", "msiof1_sync", "msiof1_rx",
+				 "msiof1_tx";
+		renesas,function = "msiof1";
+	};
 };
 
 &ether {
@@ -221,6 +227,22 @@
 	};
 };
 
+&msiof1 {
+	pinctrl-0 = <&msiof1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	pmic: pmic at 0 {
+		compatible = "renesas,r2a11302ft";
+		reg = <0>;
+		spi-max-frequency = <6000000>;
+		spi-cpol;
+		spi-cpha;
+	};
+
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.8.5.2
