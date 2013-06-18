From: rogerq@ti.com (Roger Quadros)
Date: Tue, 18 Jun 2013 19:04:46 +0300
Subject: [PATCH v2 3/4] ARM: dts: omap5-uevm: Provide USB Host PHY clock
 frequency
In-Reply-To: <1371571487-14389-1-git-send-email-rogerq@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com>
Message-ID: <1371571487-14389-4-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB Host PHY clock on port 2 must be configured to 19.2MHz.
Provide this information.

CC: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 927db1e..c0ad472 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -40,6 +40,13 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-supply = <&hsusb2_reset>;
+	/**
+	  * FIXME
+	  * Put the right clock phandle here when available
+	  *	clocks = <&auxclk1>;
+	  *	clock-names = "main_clk";
+	  */
+		clock-frequency = <19200000>;
 	};
 
 	/* HS USB Port 3 RESET */
-- 
1.7.4.1
