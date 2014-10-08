From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 22:02:44 +0400
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
In-Reply-To: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
Message-ID: <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Enable HS-USB device for the Koelsch board, defining the GPIO that the driver
should check when probing (which is the ID output from MAX3355 OTG chip).

Note that there will be pinctrl-related error messages if both internal PCI
and HS-USB drivers are enabled but they should be just ignored.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: added pin function/group and prop, moved device node, fixed summary,
added changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- added pinctrl-related properties;
- moved the HS-USB node to precede the USB PHY node;
- uppercased "arm" in the summary;
- added changelog.

 arch/arm/boot/dts/r8a7791-koelsch.dts |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -464,6 +464,13 @@
 	pinctrl-names = "default";
 };
 
+&hsusb {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };
