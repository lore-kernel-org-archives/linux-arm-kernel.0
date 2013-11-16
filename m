From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 16 Nov 2013 14:23:42 +0100
Subject: [PATCH 09/11] ARM: dts: AM33XX IGEP0033: add USB support.
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1384608224-9452-10-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add node to support the USB Host and the USB OTG on the IGEP AQUILA
Processor Board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 6196244..7063311 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -199,6 +199,35 @@
 	pinctrl-0 = <&uart0_pins>;
 };
 
+&usb {
+	status = "okay";
+
+	control at 44e10000 {
+		status = "okay";
+	};
+
+	usb-phy at 47401300 {
+		status = "okay";
+	};
+
+	usb-phy at 47401b00 {
+		status = "okay";
+	};
+
+	usb at 47401000 {
+		status = "okay";
+	};
+
+	usb at 47401800 {
+		status = "okay";
+		dr_mode = "host";
+	};
+
+	dma-controller at 07402000  {
+		status = "okay";
+	};
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
1.8.4.2
