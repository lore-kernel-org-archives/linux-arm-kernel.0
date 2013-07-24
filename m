From: rogerq@ti.com (Roger Quadros)
Date: Wed, 24 Jul 2013 17:32:34 +0300
Subject: [PATCH 2/4] ARM: dts: OMAP5: Add 60MHz clock reference to USB Host
 module
In-Reply-To: <1374676356-31286-1-git-send-email-rogerq@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Message-ID: <1374676356-31286-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB Host driver (drivers/mfd/omap-usb-host.c) expects the 60MHz
reference clock to be named "init_60m_fclk". Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index bc31022..f9f7f74 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -695,6 +695,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&l3init_60m_fclk>;
+			clock-names = "init_60m_fclk";
 
 			usbhsohci: ohci at 4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
-- 
1.7.4.1
