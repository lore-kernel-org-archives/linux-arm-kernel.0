From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Aug 2018 15:01:32 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: add dwc2 otg controller on px30
In-Reply-To: <20180802130133.4898-1-heiko@sntech.de>
References: <20180802130133.4898-1-heiko@sntech.de>
Message-ID: <20180802130133.4898-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the node for the dwc2-based otg controller on the px30 soc.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index dc3b22ca9a0e..fed782194a94 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -702,6 +702,22 @@
 			<100000000>, <200000000>;
 	};
 
+	usb20_otg: usb at ff300000 {
+		compatible = "rockchip,px30-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x0 0xff300000 0x0 0x40000>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		g-use-dma;
+		power-domains = <&power PX30_PD_USB>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb at ff340000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff340000 0x0 0x10000>;
-- 
2.17.0
