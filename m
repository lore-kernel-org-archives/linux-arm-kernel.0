From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Mon, 12 Mar 2018 09:50:48 +0800
Subject: [PATCH] arm64: dts: rockchip: assign clock rate for ACLK_VIO
Message-ID: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACLK_VIO is a parent clock used by a several children,
its suggested clock rate is 400MHz. Right now it gets 400MHz
because it sources from CPLL(800M) and divides by 2 after reset.
It's good not to rely on default values like this, so let's
explicitly set it.
NOTE: it's expected that at least one board may override cru node and
set the CPLL to 1.6 GHz. On that board it will be very important to be
explicit about aclk-vio being 400 MHz.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 6 ++++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 199a511..7d8d5de 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -580,7 +580,8 @@
 		<&cru PCLK_PERIHP>,
 		<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
 		<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
-		<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>;
+		<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
+		<&cru ACLK_VIO>;
 	assigned-clock-rates =
 		<600000000>, <800000000>,
 		<1000000000>,
@@ -588,7 +589,8 @@
 		<37500000>,
 		<100000000>, <100000000>,
 		<50000000>, <800000000>,
-		<100000000>, <50000000>;
+		<100000000>, <50000000>,
+		<400000000>;
 };
 
 &emmc_phy {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d79e9b3..91ee951 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1259,7 +1259,8 @@
 			<&cru PCLK_PERIHP>,
 			<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
 			<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
-			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>;
+			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
+			<&cru ACLK_VIO>;
 		assigned-clock-rates =
 			 <594000000>,  <800000000>,
 			<1000000000>,
@@ -1267,7 +1268,8 @@
 			  <37500000>,
 			 <100000000>,  <100000000>,
 			  <50000000>, <600000000>,
-			 <100000000>,   <50000000>;
+			 <100000000>,   <50000000>,
+			 <400000000>;
 	};
 
 	grf: syscon at ff770000 {
-- 
1.9.1
