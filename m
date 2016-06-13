From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 13 Jun 2016 16:04:35 -0700
Subject: [PATCH v2 11/11] arm64: dts: rockchip: Provide emmcclk to PHY for
 rk3399
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Message-ID: <1465859076-4868-12-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous changes in this series allowed exposing the card clock from the
rk3399 SDHCI device and allowed consuming the card clock in the rk3399
eMMC PHY.  Hook things up in the main rk3399 dtsi file.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1b57e92e0093..004b599ca285 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -225,8 +225,10 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
 		clock-names = "clk_xin", "clk_ahb";
+		clock-output-names = "emmc_cardclock";
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		#clock-cells = <0>;
 		status = "disabled";
 	};
 
@@ -621,6 +623,8 @@
 		emmc_phy: phy at f780 {
 			compatible = "rockchip,rk3399-emmc-phy";
 			reg = <0xf780 0x24>;
+			clocks = <&sdhci>;
+			clock-names = "emmcclk";
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.8.0.rc3.226.g39d4020
