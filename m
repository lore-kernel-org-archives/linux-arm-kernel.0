From: wxt@rock-chips.com (Caesar Wang)
Date: Sat,  3 Sep 2016 04:39:06 +0800
Subject: [PATCH] arm64: dts: rockchip: add the tcpc for rk3399 power domain
Message-ID: <1472848746-30135-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tcpc is the Type C Port Controller and Type C Port Delivery (tcpd)
is part of it, we haven't used them now, add it to save power consumption.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 267b812..6c89d77 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -814,6 +814,16 @@
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
+				pd_tcpc0 at RK3399_PD_TCPC0 {
+					reg = <RK3399_PD_TCPD0>;
+					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
+						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
+				};
+				pd_tcpc1 at RK3399_PD_TCPC1 {
+					reg = <RK3399_PD_TCPD1>;
+					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
+						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+				};
 				pd_vo at RK3399_PD_VO {
 					reg = <RK3399_PD_VO>;
 					#address-cells = <1>;
-- 
1.9.1
