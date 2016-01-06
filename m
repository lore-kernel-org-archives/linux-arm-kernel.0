From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  6 Jan 2016 12:03:57 +0800
Subject: [PATCH v7 5/5] ARM: dts: rockchip: add support mipi panel tv080wum-nl0
In-Reply-To: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1452053038-32098-6-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tv080wum-nl0 panel is a mipi panel, it can use in MIPI_TX socket
of rk3288 evb board.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v7:
- Move the lcd_en control to act8846 dts

Changes in v6: None
Changes in v5:
- add a blank line befor lcd_en

Changes in v4: None
Changes in v3: None

 arch/arm/boot/dts/rk3288-evb-act8846.dts |  2 ++
 arch/arm/boot/dts/rk3288-evb.dtsi        | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index e662147..7d5475b 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -50,6 +50,8 @@
 		gpio = <&gpio7 3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_en>;
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-name = "vcc_lcd";
 		vin-supply = <&vcc_io>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4faabdb..0c91858 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -47,7 +47,7 @@
 		reg = <0x0 0x80000000>;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		brightness-levels = <
 			  0   1   2   3   4   5   6   7
@@ -183,6 +183,16 @@
 	status = "okay";
 };
 
+&mipi_dsi {
+	status = "okay";
+	panel {
+		compatible ="boe,tv080wum-nl0";
+		reg = <0>;
+		backlight = <&backlight>;
+		status = "okay";
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.6.3
