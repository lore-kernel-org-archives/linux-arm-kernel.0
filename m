From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  7 Sep 2016 11:50:54 -0700
Subject: [PATCH] arm64: dts: rk3399: add powerdomain for typec
In-Reply-To: <1473272245-28841-1-git-send-email-zyw@rock-chips.com>
References: <1473272245-28841-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473274254-24950-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tcpc power domain will try to power up/down the power of Type-C PHY.
Hence, we need control it in Type-C PHY driver with the pm_runtime helper.

Change-Id: I727ed3f7c6e7075f41f0940470796ba0cd3232df
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---
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
