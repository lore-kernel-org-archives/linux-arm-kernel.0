From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 19 Sep 2012 15:02:08 +0530
Subject: [PATCH v3 3/3] ARM: dts: omap: Add usb_otg and glue data
In-Reply-To: <1348047128-25692-1-git-send-email-kishon@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
Message-ID: <1348047128-25692-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg data node in omap4/omap3 device tree file. Also update
the node with board specific setting in omapx-<board>.dts file.
The dt data specifies among others the interface type (ULPI or UTMI), mode
which is mostly OTG, power that specifies the amount of power this can supply
when in host mode.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts       |    6 ++++++
 arch/arm/boot/dts/omap3-overo.dtsi    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi          |   11 +++++++++++
 arch/arm/boot/dts/omap4-panda.dts     |    6 ++++++
 arch/arm/boot/dts/omap4-sdp.dts       |    6 ++++++
 arch/arm/boot/dts/omap4.dtsi          |   12 ++++++++++++
 7 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index c38cf76..ca37f19 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -113,3 +113,9 @@
 	 */
 	ti,pulldowns = <0x03a1c4>;
 };
+
+&usb_otg_hs {
+	interface_type = <0>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index e8ba1c2..afb9ba9 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -59,3 +59,9 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&usb_otg_hs {
+	interface_type = <0>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 89808ce..4b3d157 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -55,3 +55,9 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&usb_otg_hs {
+	interface_type = <0>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f38ea87..5c7324b 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -300,5 +300,16 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
 		};
+
+		usb_otg_hs: usb_otg_hs at 480ab000 {
+			compatible = "ti,omap3-musb";
+			reg = <0x480ab000 0x1000>;
+			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupt-names = "mc", "dma";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 6640fd9..c3ff134 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -141,3 +141,9 @@
 &twl_usb_comparator {
 	usb-supply = <&vusb>;
 };
+
+&usb_otg_hs {
+	interface_type = <1>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 406dab1..22f7ec1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -353,3 +353,9 @@
 &twl_usb_comparator {
 	usb-supply = <&vusb>;
 };
+
+&usb_otg_hs {
+	interface_type = <1>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5d1c484..79611b4 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -430,5 +430,17 @@
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
 		};
+
+		usb_otg_hs: usb_otg_hs at 4a0ab000 {
+			compatible = "ti,omap4-musb";
+			reg = <0x4a0ab000 0x7ff>,
+			      <0x4a00233c 0x4>; /* TO BE REMOVED:SCM Register */
+			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupt-names = "mc", "dma";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+		};
 	};
 };
-- 
1.7.9.5
