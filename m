From: rogerq@ti.com (Roger Quadros)
Date: Wed, 24 Jul 2013 17:32:36 +0300
Subject: [PATCH 4/4] ARM: dts: omap5-uevm: Provide USB PHY clock
In-Reply-To: <1374676356-31286-1-git-send-email-rogerq@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Message-ID: <1374676356-31286-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HS USB 2 PHY gets its clock from AUXCLK1. Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..a366cde 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -42,12 +42,8 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-supply = <&hsusb2_reset>;
-	/**
-	  * FIXME
-	  * Put the right clock phandle here when available
-	  *	clocks = <&auxclk1>;
-	  *	clock-names = "main_clk";
-	  */
+		clocks = <&auxclk1_ck>;
+		clock-names = "main_clk";
 		clock-frequency = <19200000>;
 	};
 
-- 
1.7.4.1
