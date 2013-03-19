From: rogerq@ti.com (Roger Quadros)
Date: Tue, 19 Mar 2013 16:27:00 +0200
Subject: [PATCH 2/2] ARM: dts: omap4-panda: Provide PHY clock information
In-Reply-To: <1363703220-4777-1-git-send-email-rogerq@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
Message-ID: <1363703220-4777-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PHY needs AUXCLK3 to operate. Provide this information
in the device tree.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index cfc7683..2cd369b 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -85,6 +85,8 @@
 		compatible = "usb-nop-xceiv";
 		reset-supply = <&hsusb1_reset>;
 		vcc-supply = <&hsusb1_power>;
+		clocks = <&aux_clks 3>;
+		clock-names = "main_clk";
 		clock-frequency = <19200000>;
 	};
 };
-- 
1.7.4.1
