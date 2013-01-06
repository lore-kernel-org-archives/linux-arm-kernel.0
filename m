From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:34 +0100
Subject: [PATCH 01/11] ARM: Kirkwood: Fix missing clk for USB device.
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the clock being held by a driver, it gets turned off at a bad
time causing the SoC to lockup. This is often during reboot.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mpl.ch>
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
