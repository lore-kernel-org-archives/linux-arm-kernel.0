From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 7 May 2014 00:47:59 +0400
Subject: [PATCH] ARM: shmobile: henninger: add MSIOF0 DT support
Message-ID: <201405070048.00213.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Henninger board dependent part of the MSIOF0 device node.
Add device node for Renesas R2A11302FT PMIC for which no bindings exist yet.

Based on the Koelsch MSIOF device tree patch by Geert Uytterhoeven.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.15-rc3-20140502' tag of Simon Horman's
'renesas.git' repo and SDHI0/2 and QSPI DT support patches posted recently.

 arch/arm/boot/dts/r8a7791-henninger.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
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
@@ -195,3 +201,18 @@
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
