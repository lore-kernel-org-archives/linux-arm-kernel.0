From: coelho@ti.com (Luciano Coelho)
Date: Tue, 30 Jul 2013 20:27:28 +0300
Subject: [PATCH 4/4] arm: dts: omap4-sdp: add WiLink7 device tree node
In-Reply-To: <1375205248-25708-1-git-send-email-coelho@ti.com>
References: <1375205248-25708-1-git-send-email-coelho@ti.com>
Message-ID: <1375205248-25708-5-git-send-email-coelho@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add appropriate device tree node for Blaze's WiLink7 module.  It uses
a GPIO as interrupt, so configure the gpio2 node as interrupt parent
and assign the corresponding GPIO.  Additionally, add the clock
frequencies used by the module.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 3845615..2fecca1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -150,6 +150,26 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	wlan {
+		compatible = "ti,wilink7";
+		interrupt-parent = <&gpio2>;
+		interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
+		clocks = <&refclock &tcxoclock>;
+		clock-names = "refclock tcxoclock";
+
+		refclock: refclock {
+			compatible = "ti,wilink-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+
+		tcxoclock: tcxoclock {
+			compatible = "ti,wilink-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+	 };
 };
 
 &omap4_pmx_wkup {
-- 
1.8.3.2
