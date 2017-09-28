From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 28 Sep 2017 08:17:19 +0800
Subject: [PATCH 11/12] dt-bindings: usb: mtu3: remove dummy clocks and add
 optional ones
In-Reply-To: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
Message-ID: <a3918b553f483fd1a519fe09a3e5df48c5375b60.1506509659.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove dummy clocks for usb wakeup and add optional ones for
mcu_bus and dma_bus bus.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 7c611d1..49c982b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -14,9 +14,9 @@ Required properties:
  - vusb33-supply : regulator of USB avdd3.3v
  - clocks : a list of phandle + clock-specifier pairs, one for each
 	entry in clock-names
- - clock-names : must contain "sys_ck" and "ref_ck" for clock of controller;
-	"wakeup_deb_p0" and "wakeup_deb_p1" are optional, they are
-	depends on "mediatek,enable-wakeup"
+ - clock-names : must contain "sys_ck" for clock of controller,
+	the following clocks are optional:
+	"ref_ck", "mcu_ck" and "dam_ck";
  - phys : a list of phandle + phy specifier pairs
  - dr_mode : should be one of "host", "peripheral" or "otg",
 	refer to usb/generic.txt
@@ -65,9 +65,7 @@ ssusb: usb at 11271000 {
 	clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>,
 		 <&pericfg CLK_PERI_USB0>,
 		 <&pericfg CLK_PERI_USB1>;
-	clock-names = "sys_ck", "ref_ck",
-		      "wakeup_deb_p0",
-		      "wakeup_deb_p1";
+	clock-names = "sys_ck", "ref_ck";
 	vusb33-supply = <&mt6397_vusb_reg>;
 	vbus-supply = <&usb_p0_vbus>;
 	extcon = <&extcon_usb>;
-- 
1.7.9.5
