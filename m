From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 18 Jan 2017 14:08:26 +0800
Subject: [PATCH 5/6] dt-bindings: mt8173-xhci: add reference clock
In-Reply-To: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1484719707-12107-5-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a reference clock for compatibility

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mt8173-xhci.txt        |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
index 2a930bd..ab8bb27 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
@@ -23,6 +23,7 @@ Required properties:
 	entry in clock-names
  - clock-names : must contain
 	"sys_ck": for clock of xHCI MAC
+	"ref_ck": for reference clock of xHCI MAC
 	"wakeup_deb_p0": for USB wakeup debounce clock of port0
 	"wakeup_deb_p1": for USB wakeup debounce clock of port1
 
@@ -47,10 +48,10 @@ usb30: usb at 11270000 {
 	reg-names = "mac", "ippc";
 	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-	clocks = <&topckgen CLK_TOP_USB30_SEL>,
+	clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>,
 		 <&pericfg CLK_PERI_USB0>,
 		 <&pericfg CLK_PERI_USB1>;
-	clock-names = "sys_ck",
+	clock-names = "sys_ck", "ref_ck",
 		      "wakeup_deb_p0",
 		      "wakeup_deb_p1";
 	phys = <&phy_port0 PHY_TYPE_USB3>,
@@ -82,6 +83,7 @@ Required properties:
 	entry in clock-names
  - clock-names : must be
 	"sys_ck": for clock of xHCI MAC
+	"ref_ck": for reference clock of xHCI MAC
 
 Optional properties:
  - vbus-supply : reference to the VBUS regulator;
@@ -94,8 +96,8 @@ usb30: usb at 11270000 {
 	reg-names = "mac";
 	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-	clocks = <&topckgen CLK_TOP_USB30_SEL>;
-	clock-names = "sys_ck";
+	clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+	clock-names = "sys_ck", "ref_ck";
 	vusb33-supply = <&mt6397_vusb_reg>;
 	usb3-lpm-capable;
 };
-- 
1.7.9.5
