From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 12 Apr 2017 15:10:42 +0800
Subject: [PATCH 2/4] arm64: dts: rk3399: add power domain for some peripheral
In-Reply-To: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
References: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1491981044-24635-2-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domain for sd, usb, edp.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 36 +++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 387ae34..9d44c19 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -947,6 +947,10 @@
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
+			pd_edp at RK3399_PD_EDP {
+				reg = <RK3399_PD_EDP>;
+				clocks = <&cru PCLK_EDP_CTRL>;
+			};
 			pd_emmc at RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
@@ -958,11 +962,33 @@
 					 <&cru PCLK_GMAC>;
 				pm_qos = <&qos_gmac>;
 			};
-			pd_sd at RK3399_PD_SD {
-				reg = <RK3399_PD_SD>;
-				clocks = <&cru HCLK_SDMMC>,
-					 <&cru SCLK_SDMMC>;
-				pm_qos = <&qos_sd>;
+			pd_perihp at RK3399_PD_PERIHP {
+				reg = <RK3399_PD_PERIHP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&cru ACLK_PERIHP>;
+				pm_qos = <&qos_perihp>,
+					 <&qos_pcie>,
+					 <&qos_usb_host0>,
+					 <&qos_usb_host1>;
+
+				pd_sd at RK3399_PD_SD {
+					reg = <RK3399_PD_SD>;
+					clocks = <&cru HCLK_SDMMC>,
+						 <&cru SCLK_SDMMC>;
+					pm_qos = <&qos_sd>;
+				};
+			};
+			pd_sdioaudio at RK3399_PD_SDIOAUDIO {
+				reg = <RK3399_PD_SDIOAUDIO>;
+				clocks = <&cru HCLK_SDIO>;
+				pm_qos = <&qos_sdioaudio>;
+			};
+			pd_usb3 at RK3399_PD_USB3 {
+				reg = <RK3399_PD_USB3>;
+				clocks = <&cru ACLK_USB3>;
+				pm_qos = <&qos_usb_otg0>,
+					 <&qos_usb_otg1>;
 			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
-- 
1.9.1
