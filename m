From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sat,  7 May 2016 18:21:48 +0300
Subject: [PATCH 7/7] ARM: dts: n900: enable lirc-rx51 driver
In-Reply-To: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <1462634508-24961-8-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed DT data to enable IR TX driver

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b3c26a9..3d1e23e 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -143,6 +143,18 @@
 		io-channels = <&twl_madc 0>, <&twl_madc 4>, <&twl_madc 12>;
 		io-channel-names = "temp", "bsi", "vbat";
 	};
+
+	pwm9: dmtimer-pwm at 9 {
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&timer9>;
+		ti,clock-source = <0x00>; /* timer_sys_ck */
+	};
+
+	ir: lirc-rx51 {
+		compatible = "nokia,lirc-rx51";
+		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
+	};
 };
 
 &omap3_pmx_core {
-- 
1.9.1
