From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 22 Jul 2018 13:57:39 +0800
Subject: [PATCH v3 9/9] arm64: allwinner: dts: h6: enable USB3 port on Pine H64
In-Reply-To: <20180722055739.26464-1-icenowy@aosc.io>
References: <20180722055739.26464-1-icenowy@aosc.io>
Message-ID: <20180722055739.26464-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 board have a USB3 port, which is connected to the USB3 pins of
the H6 SoC, and the 5V power supply is controlled via GPIO (shared with
the power USB ports).

Enable this port.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v3:
- Added Chen-Yu's Review tag.

 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 97016a848d5b..05a78d43e17c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -51,6 +51,10 @@
 	};
 };
 
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -220,3 +224,8 @@
 	usb3_vbus-supply = <&reg_usb_vbus>;
 	status = "okay";
 };
+
+&usb3phy {
+	phy-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
-- 
2.18.0
