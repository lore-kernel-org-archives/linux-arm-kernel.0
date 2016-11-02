From: wulf@rock-chips.com (William Wu)
Date: Wed,  2 Nov 2016 15:42:18 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: add usb2-phy otg-port support for
 rk3399
In-Reply-To: <1478072538-32081-1-git-send-email-wulf@rock-chips.com>
References: <1478072538-32081-1-git-send-email-wulf@rock-chips.com>
Message-ID: <1478072538-32081-3-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add otg-port nodes for both u2phy0 and u2phy1. The otg-port can
be used for USB2.0 part of USB3.0 OTG controller.

Signed-off-by: William Wu <wulf@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b65c193..ea2df51 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1095,6 +1095,17 @@
 			clock-output-names = "clk_usbphy0_480m";
 			status = "disabled";
 
+			u2phy0_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				status = "disabled";
+			};
+
+
 			u2phy0_host: host-port {
 				#phy-cells = <0>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1112,6 +1123,16 @@
 			clock-output-names = "clk_usbphy1_480m";
 			status = "disabled";
 
+			u2phy1_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				status = "disabled";
+			};
+
 			u2phy1_host: host-port {
 				#phy-cells = <0>;
 				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.0.0
