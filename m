From: paweljarosz3691@gmail.com (=?UTF-8?q?Pawe=C5=82=20Jarosz?=)
Date: Tue, 19 Jan 2016 13:09:21 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: add tsadc node
In-Reply-To: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
References: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
Message-ID: <1453205361-27267-4-git-send-email-paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the TSADC found on rk3066.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 58bac50..adb0258 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -188,6 +188,17 @@
 		clock-names = "timer", "pclk";
 	};
 
+	tsadc: tsadc at 20060000 {
+		compatible = "rockchip,rk3066-tsadc";
+		reg = <0x20060000 0x100>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "saradc", "apb_pclk";
+		vref-supply = <&vcc_io>;
+		status = "disabled";
+	};
+
 	usbphy: phy {
 		compatible = "rockchip,rk3066a-usb-phy", "rockchip,rk3288-usb-phy";
 		rockchip,grf = <&grf>;
-- 
1.9.1
