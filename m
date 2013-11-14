From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 11:10:41 -0800
Subject: [PATCH v3 6/8] Documentation: dt: kona-timer: Add clocks
 property
In-Reply-To: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
References: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384456243-27053-7-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frequency for the Kona timer can either be specified through the
device tree or determined by checking the rate of the clock specified
in the device tree.  Update the documentation to reflect both ways.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/kona-timer.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
index 17d88b2..b84e184 100644
--- a/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
@@ -8,13 +8,19 @@ Required properties:
 - DEPRECATED: compatible : "bcm,kona-timer"
 - reg : Register range for the timer
 - interrupts : interrupt for the timer
+- clocks: clock specifier for the kona i2c external clock
 - clock-frequency: frequency that the clock operates
 
+Only one of clocks or clock-frequency should be specified.
+
+Refer to clocks/clock-bindings.txt for generic clock consumer
+properties.
+
 Example:
 	timer at 35006000 {
 		compatible = "brcm,kona-timer";
 		reg = <0x35006000 0x1000>;
 		interrupts = <0x0 7 0x4>;
-		clock-frequency = <32768>;
+		clocks = <&hub_timer_clk>;
 	};
 
-- 
1.8.0.1
