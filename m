From: david.wu@rock-chips.com (David Wu)
Date: Wed,  9 Aug 2017 20:12:50 +0800
Subject: [PATCH v4 09/12] ARM: dts: rk322x: Add support internal phy for gmac
In-Reply-To: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502280770-2462-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds internal mac phy clock and internal mac phy reset
for rk gmac using.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f3e4ffd..3778f7d 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -611,13 +611,13 @@
 		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
 			<&cru SCLK_MAC_TX>, <&cru SCLK_MAC_REF>,
 			<&cru SCLK_MAC_REFOUT>, <&cru ACLK_GMAC>,
-			<&cru PCLK_GMAC>;
+			<&cru PCLK_GMAC>, <&cru SCLK_MAC_PHY>;
 		clock-names = "stmmaceth", "mac_clk_rx",
 			"mac_clk_tx", "clk_mac_ref",
 			"clk_mac_refout", "aclk_mac",
-			"pclk_mac";
-		resets = <&cru SRST_GMAC>;
-		reset-names = "stmmaceth";
+			"pclk_mac", "clk_macphy";
+		resets = <&cru SRST_GMAC>, <&cru SRST_MACPHY>;
+		reset-names = "stmmaceth", "mac-phy";
 		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
-- 
1.9.1
