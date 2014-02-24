From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 16:51:54 +0900
Subject: [PATCH 01/02] ARM: shmobile: Lager DT USB PCI pinctrl setup via DTS
In-Reply-To: <20140224075144.20255.59443.sendpatchset@w520>
References: <20140224075144.20255.59443.sendpatchset@w520>
Message-ID: <20140224075154.20255.72319.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add USB1 and USB2 pin configuration for Lager DT reference to
the default pinctrl setup.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790-lager.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7790-lager.dts
+++ work/arch/arm/boot/dts/r8a7790-lager.dts	2014-02-18 11:35:09.000000000 +0900
@@ -111,7 +111,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins &usb1_pins &usb2_pins>;
 	pinctrl-names = "default";
 
 	du_pins: du {
@@ -148,6 +148,16 @@
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb2";
+	};
 };
 
 &mmcif1 {
