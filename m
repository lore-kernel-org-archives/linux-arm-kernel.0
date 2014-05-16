From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:13 +0900
Subject: [PATCH 04/11] ARM: shmobile: henninger: add MSIOF0 DT support
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <667366bff7c4d38c6efa60f2e32d13c26a58d7d4.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Henninger board dependent part of the MSIOF0 device node.
Add device node for Renesas R2A11302FT PMIC for which no bindings exist yet.

Based on the Koelsch MSIOF device tree patch by Geert Uytterhoeven.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 1d715a3..cc6d992 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -114,6 +114,12 @@
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
+
+	msiof0_pins: spi1 {
+		renesas,groups = "msiof0_clk", "msiof0_sync", "msiof0_rx",
+				 "msiof0_tx";
+		renesas,function = "msiof0";
+	};
 };
 
 &scif0 {
@@ -196,3 +202,18 @@
 		};
 	};
 };
+
+&msiof0 {
+	pinctrl-0 = <&msiof0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	pmic at 0 {
+		compatible = "renesas,r2a11302ft";
+		reg = <0>;
+		spi-max-frequency = <6000000>;
+		spi-cpol;
+		spi-cpha;
+	};
+};
-- 
1.8.5.2
