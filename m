From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu,  7 Aug 2014 17:34:54 +0800
Subject: [PATCH v4 3/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1407404095-3265-1-git-send-email-kever.yang@rock-chips.com>
References: <1407404095-3265-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1407404095-3265-4-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3288 has two kind of usb controller, this add the dwc2 controller
for otg and host1.

Controller can works with usb PHY default setting and Vbus on.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

---

Changes in v4: None
Changes in v3:
- EHCI and HSIC move new for version 3.

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e7cb008..9713054 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -156,6 +156,26 @@
 		status = "disabled";
 	};
 
+	usb_host1: usb at ff540000 {
+		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+				"snps,dwc2";
+		reg = <0xff540000 0x40000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USBHOST1>;
+		clock-names = "otg";
+		status = "disabled";
+	};
+
+	usb_otg: usb at ff580000 {
+		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+				"snps,dwc2";
+		reg = <0xff580000 0x40000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG0>;
+		clock-names = "otg";
+		status = "disabled";
+	};
+
 	uart2: serial at ff690000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
 		reg = <0xff690000 0x100>;
-- 
1.9.1
