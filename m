From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Feb 2018 23:38:15 +0100
Subject: [PATCH 1/3] arm64: dts: rockchip: add Innosilicon hdmi phy node to
 rk3328
In-Reply-To: <20180216223817.2821-1-heiko@sntech.de>
References: <20180216223817.2821-1-heiko@sntech.de>
Message-ID: <20180216223817.2821-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328 uses a hdmiphy from Innosilicon, so add the necessary node
to the rk3328 soc devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 65a5cebde62d..1615effcc191 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -635,6 +635,20 @@
 		status = "disabled";
 	};
 
+	hdmiphy: phy at ff430000 {
+		compatible = "rockchip,rk3328-hdmi-phy";
+		reg = <0x0 0xff430000 0x0 0x10000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_HDMIPHY>, <&xin24m>;
+		clock-names = "sysclk", "refclk";
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
2.15.1
