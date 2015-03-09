From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:22 +0100
Subject: [PATCH 09/15] ARM: dts: sun4i: Add USB Dual Role Controller
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-10-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the otg/drc usb controller to sun4i-a10.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++++++++
 drivers/usb/musb/Kconfig         |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 2f792b6..e550415 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -574,6 +574,18 @@
 			status = "disabled";
 		};
 
+		usb_otg: usb at 01c13000 {
+			compatible = "allwinner,sun4i-a10-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ahb_gates 0>;
+			interrupts = <38>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			syscons = <&syscon>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-phy";
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 8180a3a..fab8e9a 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -65,6 +65,7 @@ comment "Platform Glue Layer"
 config USB_MUSB_SUNXI
 	tristate "Allwinner (sunxi)"
 	depends on ARCH_SUNXI
+	depends on NOP_USB_XCEIV
 	select GENERIC_PHY
 
 config USB_MUSB_DAVINCI
-- 
2.3.1
