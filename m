From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:14:27 -0200
Subject: [PATCH v2] ARM: dts: rv1108: enable eMMC support
Message-ID: <20181125211427.4926-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable eMMC support for rv1108.dtsi as it can be used across multiple
boards.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- rework evb device tree (Heiko Stuebner)
- avoid adding the evb use as it is not present on evb but
  minievb (which I don't have to test) and we are using it on a custom
  customer board.

 arch/arm/boot/dts/rv1108.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index ed8f6ca52c5b..4f4275599f7a 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -734,6 +734,27 @@
 			};
 		};
 
+		emmc {
+			emmc_clk: emmc-clk {
+				rockchip,pins = <2 RK_PB6 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+			};
+
+			emmc_cmd: emmc-cmd {
+				rockchip,pins = <2 RK_PB4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
+			};
+
+			emmc_bus8: emmc-bus8 {
+				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA1 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA2 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA3 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA5 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA6 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA7 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
+			};
+		};
+
 		sdmmc {
 			sdmmc_clk: sdmmc-clk {
 				rockchip,pins = <3 RK_PC4 RK_FUNC_1 &pcfg_pull_none_drv_4ma>;
-- 
2.19.1
