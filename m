From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 23 Nov 2016 00:59:02 +0800
Subject: [RFC PATCH 2/2] arm64: dts: enable the MUSB controller of Pine64 in
 host-only mode
In-Reply-To: <20161122165902.62543-1-icenowy@aosc.xyz>
References: <20161122165902.62543-1-icenowy@aosc.xyz>
Message-ID: <20161122165902.62543-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64 has a MUSB controller wired to the USB PHY 0, which is connected
to the upper USB Type-A port of Pine64.

As the port is a Type-A female port, enable it in host-only mode in the
device tree, which makes devices with USB Type-A male port can work on
this port (which is originally designed by Pine64 team).

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Peripheral mode is also proven to work, with dr_mode changed to "peripheral"
and using a Type-A to Type-A cable.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index f9a11e6..cf91051 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -81,6 +81,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.10.2
