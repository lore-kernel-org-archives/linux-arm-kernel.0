From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Dec 2012 19:45:01 +0100
Subject: [PATCH] ARM: Kirkwood: Fix missing clk for USB device.
Message-ID: <1356201902-20448-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the clock being held by a driver, it ges turned off at a bad
time causing the SoC to lockup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7735cee..110d6cb 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -144,6 +144,7 @@
 			compatible = "marvell,orion-ehci";
 			reg = <0x50000 0x1000>;
 			interrupts = <19>;
+			clocks = <&gate_clk 3>;
 			status = "okay";
 		};
 
-- 
1.7.10.4
