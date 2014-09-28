From: jinkun.hong@rock-chips.com (jinkun.hong)
Date: Sun, 28 Sep 2014 03:22:54 -0700
Subject: [PATCH v2 3/3] ARM: dts: add rk3288 power-domain node
In-Reply-To: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
References: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <1411899774-8484-4-git-send-email-jinkun.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "jinkun.hong" <jinkun.hong@rock-chips.com>

Signed-off-by: Jack Dai <jack.dai@rock-chips.com>
Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>

---

Changes in v2:
Adviced by Daniel
- make pd_vio clocks all one entry per line and alphabetize.
Adviced by Heiko
- power: power-controller move back to pinctrl: pinctrl.

 arch/arm/boot/dts/rk3288.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 54ec8c8..8ad77c5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
+#include <dt-bindings/power-domain/rk3288.h>
 #include "skeleton.dtsi"
 
 / {
@@ -1004,4 +1005,70 @@
 			};
 		};
 	};
+
+	power: power-controller {
+		compatible = "rockchip,rk3288-power-controller";
+		#power-domain-cells = <1>;
+		rockchip,pmu = <&pmu>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_gpu {
+			reg = <RK3288_PD_GPU>;
+			clocks = <&cru ACLK_GPU>;
+		};
+
+		pd_hevc {
+			reg = <RK3288_PD_HEVC>;
+			clocks = <&cru ACLK_HEVC>,
+				 <&cru SCLK_HEVC_CABAC>,
+				 <&cru SCLK_HEVC_CORE>,
+				 <&cru HCLK_HEVC>;
+		};
+
+		pd_vio {
+			reg = <RK3288_PD_VIO>;
+			clocks = <&cru ACLK_IEP>,
+				 <&cru ACLK_ISP>,
+				 <&cru ACLK_RGA_NIU>,
+				 <&cru ACLK_RGA>,
+				 <&cru ACLK_VIO0_NIU>,
+				 <&cru ACLK_VIO1_NIU>,
+				 <&cru ACLK_VIP>,
+				 <&cru ACLK_VOP0>,
+				 <&cru ACLK_VOP1>,
+				 <&cru DCLK_VOP0>,
+				 <&cru DCLK_VOP1>,
+				 <&cru HCLK_IEP>,
+				 <&cru HCLK_ISP>,
+				 <&cru HCLK_RGA>,
+				 <&cru HCLK_VIO_AHB_ARBI>,
+				 <&cru HCLK_VIO_NIU>,
+				 <&cru HCLK_VIO2_H2P>,
+				 <&cru HCLK_VIP>,
+				 <&cru HCLK_VOP0>,
+				 <&cru HCLK_VOP1>,
+				 <&cru PCLK_EDP_CTRL>,
+				 <&cru PCLK_HDMI_CTRL>,
+				 <&cru PCLK_LVDS_PHY>,
+				 <&cru PCLK_MIPI_CSI>,
+				 <&cru PCLK_MIPI_DSI0>,
+				 <&cru PCLK_MIPI_DSI1>,
+				 <&cru PCLK_VIO2_H2P>,
+				 <&cru SCLK_EDP_24M>,
+				 <&cru SCLK_EDP>,
+				 <&cru SCLK_HDMI_CEC>,
+				 <&cru SCLK_HDMI_HDCP>,
+				 <&cru SCLK_ISP_JPE>,
+				 <&cru SCLK_ISP>,
+				 <&cru SCLK_RGA>;
+		};
+
+		pd_video {
+			reg = <RK3288_PD_VIDEO>;
+			/* FIXME: add clocks */
+			clocks = <&cru ACLK_VCODEC>,
+				 <&cru HCLK_VCODEC>;
+		};
+	};
 };
-- 
1.7.9.5
