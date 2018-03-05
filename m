From: d.schultz@phytec.de (Daniel Schultz)
Date: Mon, 5 Mar 2018 13:45:11 +0100
Subject: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
Message-ID: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---

The binding will be added with the next merge of net-next:
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570

 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index bdd80aa..e60535d 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -141,6 +141,7 @@
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 			enet-phy-lane-no-swap;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_CHN_A_TCLK>;
 		};
 	};
 };
-- 
2.7.4
