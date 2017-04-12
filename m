From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 12 Apr 2017 15:10:44 +0800
Subject: [PATCH 4/4] arm64: dts: rk3399: add pinctrl for some peripheral
In-Reply-To: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
References: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1491981044-24635-4-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl for sdio, sdmmc, pcie, spdif, hdmi.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 113 +++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 54a5340..0096c70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1737,6 +1737,91 @@
 			};
 		};
 
+		sdio0 {
+			sdio0_bus1: sdio0-bus1 {
+				rockchip,pins =
+					<2 RK_PC4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_bus4: sdio0-bus4 {
+				rockchip,pins =
+					<2 RK_PC4 RK_FUNC_1 &pcfg_pull_up>,
+					<2 RK_PC5 RK_FUNC_1 &pcfg_pull_up>,
+					<2 RK_PC6 RK_FUNC_1 &pcfg_pull_up>,
+					<2 RK_PC7 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_cmd: sdio0-cmd {
+				rockchip,pins =
+					<2 RK_PD0 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_clk: sdio0-clk {
+				rockchip,pins =
+					<2 RK_PD1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdio0_cd: sdio0-cd {
+				rockchip,pins =
+					<2 RK_PD2 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_pwr: sdio0-pwr {
+				rockchip,pins =
+					<2 RK_PD3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_bkpwr: sdio0-bkpwr {
+				rockchip,pins =
+					<2 RK_PD4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_wp: sdio0-wp {
+				rockchip,pins =
+					<0 RK_PA3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_int: sdio0-int {
+				rockchip,pins =
+					<0 RK_PA4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		sdmmc {
+			sdmmc_bus1: sdmmc-bus1 {
+				rockchip,pins =
+					<4 RK_PB0 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_bus4: sdmmc-bus4 {
+				rockchip,pins =
+					<4 RK_PB0 RK_FUNC_1 &pcfg_pull_up>,
+					<4 RK_PB1 RK_FUNC_1 &pcfg_pull_up>,
+					<4 RK_PB2 RK_FUNC_1 &pcfg_pull_up>,
+					<4 RK_PB3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_clk: sdmmc-clk {
+				rockchip,pins =
+					<4 RK_PB4 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdmmc_cmd: sdmmc-cmd {
+				rockchip,pins =
+					<4 RK_PB5 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_cd: sdmcc-cd {
+				rockchip,pins =
+					<0 RK_PA7 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_wp: sdmmc-wp {
+				rockchip,pins =
+					<0 RK_PB0 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 		sleep {
 			ap_pwroff: ap-pwroff {
 				rockchip,pins = <1 RK_PA5 RK_FUNC_1 &pcfg_pull_none>;
@@ -1752,6 +1837,11 @@
 				rockchip,pins =
 					<4 RK_PC5 RK_FUNC_1 &pcfg_pull_none>;
 			};
+
+			spdif_bus_1: spdif-bus-1 {
+				rockchip,pins =
+					<3 RK_PC0 RK_FUNC_3 &pcfg_pull_none>;
+			};
 		};
 
 		spi0 {
@@ -2011,6 +2101,19 @@
 			};
 		};
 
+		hdmi {
+			hdmi_i2c_xfer: hdmi-i2c-xfer {
+				rockchip,pins =
+					<4 RK_PC1 RK_FUNC_3 &pcfg_pull_none>,
+					<4 RK_PC0 RK_FUNC_3 &pcfg_pull_none>;
+			};
+
+			hdmi_cec: hdmi-cec {
+				rockchip,pins =
+					<4 RK_PC7 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		pcie {
 			pcie_clkreqn: pci-clkreqn {
 				rockchip,pins =
@@ -2021,6 +2124,16 @@
 				rockchip,pins =
 					<4 RK_PD0 RK_FUNC_1 &pcfg_pull_none>;
 			};
+
+			pcie_clkreqn_cpm: pci-clkreqn-cpm {
+				rockchip,pins =
+					<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
+			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
+				rockchip,pins =
+					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
 		};
 
 	};
-- 
1.9.1
