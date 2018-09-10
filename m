From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 11:28:40 +0200
Subject: [PATCH v3 1/4] arm64: dts: rockchip: add Innosilicon hdmi phy node to
 rk3328
In-Reply-To: <20180910092843.1700-1-heiko@sntech.de>
References: <20180910092843.1700-1-heiko@sntech.de>
Message-ID: <20180910092843.1700-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328 uses a hdmiphy from Innosilicon, so add the necessary node
to the rk3328 soc devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 2e3bd93c508c..beebab74ce17 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -616,6 +616,20 @@
 		status = "disabled";
 	};
 
+	hdmiphy: phy at ff430000 {
+		compatible = "rockchip,rk3328-hdmi-phy";
+		reg = <0x0 0xff430000 0x0 0x10000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_HDMIPHY>, <&xin24m>, <&cru DCLK_HDMIPHY>;
+		clock-names = "sysclk", "refoclk", "refpclk";
+		clock-output-names = "hdmi_phy";
+		#clock-cells = <0>;
+		nvmem-cells = <&efuse_cpu_version>;
+		nvmem-cell-names = "cpu-version";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	cru: clock-controller at ff440000 {
 		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
 		reg = <0x0 0xff440000 0x0 0x1000>;
-- 
2.17.0
