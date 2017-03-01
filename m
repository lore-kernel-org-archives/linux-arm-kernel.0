From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Mar 2017 00:56:21 +0100
Subject: [PATCH 4/4] ARM: dts: rockchip: add rk322x dw-mmc resets
In-Reply-To: <20170301235621.31726-1-heiko@sntech.de>
References: <20170301235621.31726-1-heiko@sntech.de>
Message-ID: <20170301235621.31726-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw-mmc got its reset-properties specified, so add the softresets
for it in rk3228/rk3229.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9dff8221112c..7cc344684f71 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -414,6 +414,8 @@
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+		resets = <&cru SRST_EMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.11.0
