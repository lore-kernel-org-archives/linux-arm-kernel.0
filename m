From: lyz@rock-chips.com (Yunzhi Li)
Date: Fri,  5 Dec 2014 20:52:20 +0800
Subject: [PATCH v2 4/5] ARM: dts: add rk3288 usb PHY
In-Reply-To: <1417783941-2418-1-git-send-email-lyz@rock-chips.com>
References: <1417783941-2418-1-git-send-email-lyz@rock-chips.com>
Message-ID: <1417783941-2418-5-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt nodes for rk3288 usb PHY.

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..a663c4c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -329,12 +329,21 @@
 		status = "disabled";
 	};
 
+	usbphy: phy {
+		#phy-cells = <1>;
+		compatible = "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb at ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
 		clock-names = "usbhost";
+		phys = <&usbphy 1>;
+		phy-names = "usb";
 		status = "disabled";
 	};
 
@@ -347,6 +356,8 @@
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
+		phys = <&usbphy 2>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -357,6 +368,8 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		phys = <&usbphy 0>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
-- 
2.0.0
