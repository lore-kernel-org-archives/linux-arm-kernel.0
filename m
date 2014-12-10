From: lyz@rock-chips.com (Yunzhi Li)
Date: Wed, 10 Dec 2014 18:46:10 +0800
Subject: [PATCH v5 4/5] ARM: dts: rockchip: add rk3288 usb PHY
In-Reply-To: <1418208371-18851-1-git-send-email-lyz@rock-chips.com>
References: <1418208371-18851-1-git-send-email-lyz@rock-chips.com>
Message-ID: <1418208371-18851-5-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device_node for RK3288 SoC usb phy. It also
defines the phy to be used by three usb controllers: usb_host0/1
and usb_otg.

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

---

Changes in v5:
- reorder the phy dt node to a correct position.

Changes in v4:
- Add phy subnodes.

Changes in v3: None

 arch/arm/boot/dts/rk3288.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..bd2a1e0 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -335,6 +335,8 @@
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
 		clock-names = "usbhost";
+		phys = <&usbphy 1>;
+		phy-names = "usb";
 		status = "disabled";
 	};
 
@@ -347,6 +349,8 @@
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
+		phys = <&usbphy 2>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -357,6 +361,8 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		phys = <&usbphy 0>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -497,6 +503,27 @@
 		interrupts = <GIC_PPI 9 0xf04>;
 	};
 
+	usbphy: phy {
+		compatible = "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		#phy-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usb-phy at 0 {
+			reg = <0>;
+		};
+
+		usb-phy at 1 {
+			reg = <1>;
+		};
+
+		usb-phy at 2 {
+			reg = <2>;
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.0.0
