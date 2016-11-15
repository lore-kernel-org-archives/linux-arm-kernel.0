From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Nov 2016 21:51:04 +0800
Subject: [PATCH v2 1/3] ARM: dts: sun7i: bananapi-m1-plus: Enable USB PHY for
 USB host support
In-Reply-To: <20161115135106.438-1-wens@csie.org>
References: <20161115135106.438-1-wens@csie.org>
Message-ID: <20161115135106.438-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2 USB host ports are directly tied to the 2 USB hosts in the SoC.
The 2 host pairs were already enabled, but the USB PHY wasn't.
VBUS on the 2 ports are always on.

Enable the USB PHY.

Fixes: 04c85ecad32a ("ARM: dts: sun7i: Add dts file for Bananapi M1 Plus
		      board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index ba5bca0fe997..44377a98cc89 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -227,3 +227,8 @@
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usbphy {
+	/* VBUS on usb host ports are tied to DC5V and therefore always on */
+	status = "okay";
+};
-- 
2.10.2
