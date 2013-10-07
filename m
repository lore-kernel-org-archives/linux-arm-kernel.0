From: rogerq@ti.com (Roger Quadros)
Date: Mon, 7 Oct 2013 16:28:13 +0300
Subject: [PATCH 1/1] ARM: dts: omap3:  Adapt USB OTG to generic PHY framework
In-Reply-To: <1381152493-28055-1-git-send-email-rogerq@ti.com>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com>
Message-ID: <1381152493-28055-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic PHY framewrok expects different properties than the
old USB PHY framework. Supply those properties.

Fixes USB OTG port on GAT04 and N900 after the Generic PHY framework was
merged in greg/usb-next. [1]

[1] - https://lkml.org/lkml/2013/9/27/581

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-gta04.dts |    2 ++
 arch/arm/boot/dts/omap3-n900.dts  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index a84684a..b9b55c9 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -131,6 +131,8 @@
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index d64fa04..e13b697 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -87,6 +87,8 @@
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 	mode = <2>;
 	power = <50>;
 };
-- 
1.7.4.1
