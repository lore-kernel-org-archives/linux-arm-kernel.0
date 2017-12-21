From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 21 Dec 2017 23:05:37 +0800
Subject: [PATCH 2/2] ARM: sun8i: v3s: enable EHCI/OHCI for Lichee Pi Zero
In-Reply-To: <20171221150537.20304-1-icenowy@aosc.io>
References: <20171221150537.20304-1-icenowy@aosc.io>
Message-ID: <20171221150537.20304-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the USB port on Lichee Pi Zero works in the OTG mode, enable the
EHCI/OHCI controllers for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
index 387fc2aa546d..cf2d9fe3bbb7 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
@@ -77,6 +77,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-0 = <&mmc0_pins_a>;
 	pinctrl-names = "default";
@@ -86,6 +90,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins_a>;
 	pinctrl-names = "default";
-- 
2.14.2
