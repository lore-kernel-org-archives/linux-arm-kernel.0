From: romain.perier@gmail.com (Romain Perier)
Date: Sat, 20 Jun 2015 12:27:16 +0000
Subject: [PATCH] ARM: dts: rockchip: Add STMMAC reset signal in GMAC interface
 for rk3288
Message-ID: <1434803236-20884-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which fixes warning "no reset control found" by the same time

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 22316d0..47476d5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -447,6 +447,8 @@
 			"mac_clk_rx", "mac_clk_tx",
 			"clk_mac_ref", "clk_mac_refout",
 			"aclk_mac", "pclk_mac";
+		resets = <&cru SRST_MAC>;
+		reset-names = "stmmaceth";
 		status = "disabled";
 	};
 
-- 
1.9.1
