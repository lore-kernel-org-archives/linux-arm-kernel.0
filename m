From: lyz@rock-chips.com (Yunzhi Li)
Date: Fri, 12 Dec 2014 23:12:21 +0800
Subject: [PATCH v7 4/5] ARM: dts: rockchip: add rk3288 usb PHY
In-Reply-To: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
References: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
Message-ID: <1418397141-1079-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device_node for RK3288 SoC usb phy. It also
defines the phy to be used by three usb controllers: usb_host0/1
and usb_otg.

Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

---

Changes in v7:
- Update dtsi for new usb phy driver.

Changes in v6: None
Changes in v5:
- reorder the phy dt node to a correct position.

Changes in v4:
- Add phy subnodes.

Changes in v3: None

 arch/arm/boot/dts/rk3288.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..2a9a029 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -335,6 +335,8 @@
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
 		clock-names = "usbhost";
+		phys = <&usbphy1>;
+		phy-names = "usb";
 		status = "disabled";
 	};
 
@@ -347,6 +349,8 @@
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
+		phys = <&usbphy2>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -357,6 +361,8 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		phys = <&usbphy0>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -497,6 +503,35 @@
 		interrupts = <GIC_PPI 9 0xf04>;
 	};
 
+	usbphy: phy {
+		compatible = "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy0 {
+			#phy-cells = <0>;
+			reg = <0x320>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+		};
+
+		usbphy1: usb-phy1 {
+			#phy-cells = <0>;
+			reg = <0x334>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+		};
+
+		usbphy2: usb-phy2 {
+			#phy-cells = <0>;
+			reg = <0x348>;
+			clocks = <&cru SCLK_OTGPHY2>;
+			clock-names = "phyclk";
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.0.0
