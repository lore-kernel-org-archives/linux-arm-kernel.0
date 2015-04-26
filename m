From: lyz@rock-chips.com (Yunzhi Li)
Date: Sun, 26 Apr 2015 17:41:38 +0800
Subject: [PATCH v1 1/2] ARM: dts: rockchip: add properties for dwc2 usb otg
 controller
Message-ID: <1430041299-24874-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties for dwc2 usb device controller according to
Documentation/devicetree/bindings/usb/dwc2.txt

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index eccc78d..2b55b07 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -432,6 +432,7 @@
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
+		dr_mode = "host";
 		status = "disabled";
 	};
 
@@ -442,6 +443,11 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <275>;
+		g-tx-fifo-size = <256 128 128 64 64 32>;
+		g-use-dma;
 		status = "disabled";
 	};
 
-- 
2.0.0
