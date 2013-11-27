From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 27 Nov 2013 17:28:14 +0900
Subject: [PATCH 04/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
In-Reply-To: <20131127082736.20015.21303.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
Message-ID: <20131127082814.20015.72207.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Configure the r7s72100 PINCTRL hardware and select pin function
for the SCIF2 serial console.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0009/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-27 17:13:43.000000000 +0900
@@ -58,3 +58,13 @@
 	};
 
 };
+
+&pfc {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_txd_p3_0", "scif2_rxd_p3_2";
+		renesas,function = "scif2";
+	};
+};
