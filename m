From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 21 Nov 2016 10:17:46 +0800
Subject: [PATCH v2.1 7/9] arm64: dts: rockchip: add pd_edp node for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1479694666-4384-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

This patch adds the below pd_edp information for rk3399.
1. add pd_edp node for RK3399 SoC
2. add the pd support for edp

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---

Changes in v2.1: (Hope the v3 will fix the display stuff with upstream)
- change the commit message as Doug comments on
  https://patchwork.kernel.org/patch/9419241

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index db72033..7354c63 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -838,6 +838,10 @@
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
+			pd_edp at RK3399_PD_EDP {
+				reg = <RK3399_PD_EDP>;
+				clocks = <&cru PCLK_EDP_CTRL>;
+			};
 			pd_emmc at RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
@@ -1388,6 +1392,7 @@
 		status = "disabled";
 		pinctrl-names = "default";
 		pinctrl-0 = <&edp_hpd>;
+		power-domains = <&power RK3399_PD_EDP>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.7.4
