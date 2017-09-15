From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 10:33:57 +0200
Subject: [PATCH 9/9] ARM: dts: rockchip: add rk3066/rk3188 power-domains
In-Reply-To: <20170915083357.11296-1-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
Message-ID: <20170915083357.11296-10-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the power-domain nodes to both rk3066 and rk3188 including
their clocks and qos connections.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b76119dd5733..8f8ce8cc9caf 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3066a-cru.h>
+#include <dt-bindings/power/rk3066-power.h>
 #include "rk3xxx.dtsi"
 
 / {
@@ -680,6 +681,56 @@
 	dma-names = "rx-tx";
 };
 
+&pmu {
+	power: power-controller {
+		compatible = "rockchip,rk3066-power-controller";
+		#power-domain-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_vio at RK3066_PD_VIO {
+			reg = <RK3066_PD_VIO>;
+			clocks = <&cru ACLK_LCDC0>,
+				 <&cru ACLK_LCDC1>,
+				 <&cru DCLK_LCDC0>,
+				 <&cru DCLK_LCDC1>,
+				 <&cru HCLK_LCDC0>,
+				 <&cru HCLK_LCDC1>,
+				 <&cru SCLK_CIF1>,
+				 <&cru ACLK_CIF1>,
+				 <&cru HCLK_CIF1>,
+				 <&cru SCLK_CIF0>,
+				 <&cru ACLK_CIF0>,
+				 <&cru HCLK_CIF0>,
+				 <&cru ACLK_IPP>,
+				 <&cru HCLK_IPP>,
+				 <&cru ACLK_RGA>,
+				 <&cru HCLK_RGA>;
+			pm_qos = <&qos_lcdc0>,
+				 <&qos_lcdc1>,
+				 <&qos_cif0>,
+				 <&qos_cif1>,
+				 <&qos_ipp>,
+				 <&qos_rga>;
+		};
+
+		pd_video at RK3066_PD_VIDEO {
+			reg = <RK3066_PD_VIDEO>;
+			clocks = <&cru ACLK_VDPU>,
+				 <&cru ACLK_VEPU>,
+				 <&cru HCLK_VDPU>,
+				 <&cru HCLK_VEPU>;
+			pm_qos = <&qos_vpu>;
+		};
+
+		pd_gpu at RK3066_PD_GPU {
+			reg = <RK3066_PD_GPU>;
+			clocks = <&cru ACLK_GPU>;
+			pm_qos = <&qos_gpu>;
+		};
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_out>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9e24d0ffadac..261daddc24a5 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3188-cru.h>
+#include <dt-bindings/power/rk3188-power.h>
 #include "rk3xxx.dtsi"
 
 / {
@@ -607,6 +608,53 @@
 	pinctrl-0 = <&i2c4_xfer>;
 };
 
+&pmu {
+	power: power-controller {
+		compatible = "rockchip,rk3188-power-controller";
+		#power-domain-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_vio at RK3188_PD_VIO {
+			reg = <RK3188_PD_VIO>;
+			clocks = <&cru ACLK_LCDC0>,
+				 <&cru ACLK_LCDC1>,
+				 <&cru DCLK_LCDC0>,
+				 <&cru DCLK_LCDC1>,
+				 <&cru HCLK_LCDC0>,
+				 <&cru HCLK_LCDC1>,
+				 <&cru SCLK_CIF0>,
+				 <&cru ACLK_CIF0>,
+				 <&cru HCLK_CIF0>,
+				 <&cru ACLK_IPP>,
+				 <&cru HCLK_IPP>,
+				 <&cru ACLK_RGA>,
+				 <&cru HCLK_RGA>;
+			pm_qos = <&qos_lcdc0>,
+				 <&qos_lcdc1>,
+				 <&qos_cif0>,
+				 <&qos_cif1>,
+				 <&qos_ipp>,
+				 <&qos_rga>;
+		};
+
+		pd_video at RK3188_PD_VIDEO {
+			reg = <RK3188_PD_VIDEO>;
+			clocks = <&cru ACLK_VDPU>,
+				 <&cru ACLK_VEPU>,
+				 <&cru HCLK_VDPU>,
+				 <&cru HCLK_VEPU>;
+			pm_qos = <&qos_vpu>;
+		};
+
+		pd_gpu at RK3188_PD_GPU {
+			reg = <RK3188_PD_GPU>;
+			clocks = <&cru ACLK_GPU>;
+			pm_qos = <&qos_gpu>;
+		};
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_out>;
-- 
2.14.1
