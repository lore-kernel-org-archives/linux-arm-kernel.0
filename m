From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 20 Nov 2013 16:36:59 +0900
Subject: [PATCH] ARM: shmobile: Configure r8a7791 PFC on Koelsch via DTS
Message-ID: <20131120073659.22718.79556.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Configure the "D" set of data signals for SCIF0 and SCIF1
on the Koelsch board to setup pinctrl serial console bits.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791-koelsch-reference.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-11-20 16:23:06.000000000 +0900
@@ -30,3 +30,19 @@
 		#size-cells = <1>;
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_d";
+		renesas,function = "scif0";
+	};
+
+	scif1_pins: serial1 {
+		renesas,groups = "scif1_data_d";
+		renesas,function = "scif1";
+	};
+};
+
