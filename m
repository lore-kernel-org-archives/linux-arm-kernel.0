From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:51 +0200
Subject: [PATCH 2/6] ARM: dts: rockchip: add dwc2 controllers for rk3066 and
 rk3188
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the two dwc2 controllers providing an otg and a designated host port.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index c021df3..c873624 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -91,6 +91,24 @@
 		status = "disabled";
 	};
 
+	usb_otg: usb at 10180000 {
+		compatible = "rockchip,rk3066-usb", "snps,dwc2";
+		reg = <0x10180000 0x40000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG0>;
+		clock-names = "otg";
+		status = "disabled";
+	};
+
+	usb_host: usb at 101c0000 {
+		compatible = "snps,dwc2";
+		reg = <0x101c0000 0x40000>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG1>;
+		clock-names = "otg";
+		status = "disabled";
+	};
+
 	mmc0: dwmmc at 10214000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10214000 0x1000>;
-- 
2.0.1
