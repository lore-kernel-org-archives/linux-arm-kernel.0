From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:18 +0900
Subject: [PATCH 44/69] ARM: shmobile: Configure r8a7791 PFC on Koelsch via DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <b91a89cf8d9880d1d82c7f9f4c1a448bb680dc2c.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Configure the "D" set of data signals for SCIF0 and SCIF1
on the Koelsch board to setup pinctrl serial console bits.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
index 1a0f082..8e7e917 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
@@ -30,3 +30,18 @@
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
-- 
1.8.4
