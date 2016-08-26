From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 26 Aug 2016 08:00:44 +0800
Subject: [PATCH] arm64: dts: rockchip: set to CCI clock of RK3399 to 600M
Message-ID: <1472169644-32560-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunqian Zheng <zhengsq@rock-chips.com>

Per testing, this can reduce the memory latency and d8 gets
better socres.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index bc86e8c..962f65d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -935,7 +935,7 @@
 			<&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
 			<&cru PCLK_PERIHP>,
 			<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
-			<&cru PCLK_PERILP0>,
+			<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
 			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>;
 		assigned-clock-rates =
 			 <594000000>,  <800000000>,
@@ -943,7 +943,7 @@
 			 <150000000>,   <75000000>,
 			  <37500000>,
 			 <100000000>,  <100000000>,
-			  <50000000>,
+			  <50000000>, <600000000>,
 			 <100000000>,   <50000000>;
 	};
 
-- 
1.9.1
