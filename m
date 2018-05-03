From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  4 May 2018 02:38:47 +0800
Subject: [PATCH 7/7] arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Message-ID: <20180503183847.11046-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 board has a PCF8563 dedicated RTC connected to its R_I2C bus.

Enable the R_I2C bus and add the RTC to the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index d36de5eb81f3..b6f2d6b2ecae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -22,6 +22,16 @@
 	};
 };
 
+&r_i2c {
+	status = "okay";
+
+	pcf8563: rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.15.1
