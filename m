From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  7 Sep 2016 16:06:17 -0700
Subject: [PATCH v2 2/2] arm64: dts: rk3399: add powerdomain for typec
In-Reply-To: <1473289577-14101-1-git-send-email-zyw@rock-chips.com>
References: <1473289577-14101-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473289577-14101-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tcpc power domain will try to power up/down the power of Type-C PHY.
Hence, we need control it in Type-C PHY driver with the pm_runtime helper.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8c51095..3eb52b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1262,6 +1262,7 @@
 		clock-names = "tcpdcore", "tcpdphy-ref";
 		assigned-clocks = <&cru SCLK_UPHY0_TCPDCORE>;
 		assigned-clock-rates = <50000000>;
+		power-domains = <&power RK3399_PD_TCPD0>;
 		resets = <&cru SRST_UPHY0>,
 			 <&cru SRST_UPHY0_PIPE_L00>,
 			 <&cru SRST_P_UPHY0_TCPHY>;
@@ -1290,6 +1291,7 @@
 		clock-names = "tcpdcore", "tcpdphy-ref";
 		assigned-clocks = <&cru SCLK_UPHY1_TCPDCORE>;
 		assigned-clock-rates = <50000000>;
+		power-domains = <&power RK3399_PD_TCPD1>;
 		resets = <&cru SRST_UPHY1>,
 			 <&cru SRST_UPHY1_PIPE_L00>,
 			 <&cru SRST_P_UPHY1_TCPHY>;
-- 
1.9.1
