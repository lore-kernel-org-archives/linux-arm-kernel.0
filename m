From: rogerq@ti.com (Roger Quadros)
Date: Tue, 24 Sep 2013 11:53:56 +0300
Subject: [PATCH v3 10/10] ARM: dts: omap3-beagle: Add USB OTG PHY details
In-Reply-To: <1380012836-29900-1-git-send-email-rogerq@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
Message-ID: <1380012836-29900-11-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add information about the USB OTG PHY. Without this
the OTG port on beagle will not work.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 1237822..7669c16 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -169,3 +169,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio1_pins>;
 };
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};
-- 
1.7.4.1
