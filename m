From: petr@barix.com (Petr Kulhavy)
Date: Fri,  1 Apr 2016 17:42:04 +0200
Subject: [PATCH 2/3] ARM: DTS: da850: add node for i2c1
In-Reply-To: <1459525325-25470-1-git-send-email-petr@barix.com>
References: <1459525325-25470-1-git-send-email-petr@barix.com>
Message-ID: <1459525325-25470-3-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

da850 has two I2C controllers, but the node for i2c1 was missing.
Add node for i2c1 controller and i2c1 pinmux pins.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/boot/dts/da850.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 42948496b8f7..136c422204d3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -63,6 +63,12 @@
 					0x10 0x00002200 0x0000ff00
 				>;
 			};
+			i2c1_pins: pinmux_i2c1_pins {
+				pinctrl-single,bits = <
+				/* I2C1_SDA,I2C1_SCL */
+				0x10 0x00440000 0x00ff0000
+				>;
+			};
 			mmc0_pins: pinmux_mmc_pins {
 				pinctrl-single,bits = <
 					/* MMCSD0_DAT[3] MMCSD0_DAT[2]
@@ -226,6 +232,14 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+		i2c1: i2c at 228000 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x228000 0x1000>;
+			interrupts = <51>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 		wdt: wdt at 21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
-- 
1.9.1
