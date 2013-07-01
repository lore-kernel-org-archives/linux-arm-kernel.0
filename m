From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 01 Jul 2013 22:45:02 +0200
Subject: [PATCH,
 RESEND] arm: kirkwood: readynas duo v2: Add GMT G762 Fan Controller
Message-ID: <874nceui0h.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that GMT G762 PWM Fan Controller is available upstream, let's add
missing bindings in Netgear ReadyNAS Duo v2 .dts file.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason and Andrew,

This one applies and has been tested against Stephen Rothwell tree.
Can you make it flow to Linus tree during the merge window?

Following Thomas feedback, this is a resend of previous version, this
time w/o fixes for bad spaces at the end of the file. Just tell me if
I should send a separate one for that purpose.

Thanks in advance.

Cheers,

a+

 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index ad6ade7..cc43d24 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -52,6 +52,17 @@
 			};
 		};
 
+		clocks {
+		       #address-cells = <1>;
+		       #size-cells = <0>;
+
+		       g762_clk: fixedclk {
+				 compatible = "fixed-clock";
+				 #clock-cells = <0>;
+				 clock-frequency = <8192>;
+		       };
+		};
+
 		i2c at 11000 {
 			status = "okay";
 
@@ -59,6 +70,15 @@
 				compatible = "ricoh,rs5c372a";
 				reg = <0x32>;
 			};
+
+			g762: g762 at 3e {
+				compatible = "gmt,g762";
+				reg = <0x3e>;
+				clocks = <&g762_clk>; /* input clock */
+				fan_gear_mode = <0>;
+				fan_startv = <1>;
+				pwm_polarity = <0>;
+			};
 		};
 
 		serial at 12000 {
-- 
1.8.3.1
