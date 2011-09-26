From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 26 Sep 2011 18:50:20 +0200
Subject: [PATCH 12/13] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Message-ID: <1317055821-20652-13-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required clock frequencies for the i2c client devices existing
on beagle board.

Add the twl4030 basic description with only the twl_rtc module.

Add the EEPROM node.

Based on original patch from Manju:
http://www.spinics.net/lists/linux-omap/msg55831.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   38 ++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 9486be6..a65f39d 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -27,3 +27,41 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	/*
+	 * Integrated Power Management Chip
+	 */
+	twl at 48 {
+		compatible = "ti,twl4030";
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&intc>;
+
+		twl_rtc {
+			compatible = "ti,twl4030-rtc";
+			interrupts = <11>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	/*
+	 * Display monitor features are burnt in the EEPROM
+	 * as EDID data.
+	 */
+	eeprom at 50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
+};
-- 
1.7.0.4
