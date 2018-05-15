From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:54:54 +0200
Subject: [PATCH v2 1/4] arm64: dts: rockchip: add Innosilicon hdmi phy node to
 rk3328
In-Reply-To: <20180515135457.6252-1-heiko@sntech.de>
References: <20180515135457.6252-1-heiko@sntech.de>
Message-ID: <20180515135457.6252-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328 uses a hdmiphy from Innosilicon, so add the necessary node
to the rk3328 soc devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>
---
changes in v2:
- adapt to changed clock names

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 60b3ed5918e7..04d81ea0924e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -645,6 +645,20 @@
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
