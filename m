From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  4 Jul 2017 17:11:45 +0800
Subject: [PATCH] arm64: dts: hi3660: remove num-slots from DT
Message-ID: <1499159505-65972-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Li Wei <liwei213@huawei.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..70794fc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -797,7 +797,6 @@
 			#size-cells = <0>;
 			cd-inverted;
 			compatible = "hisilicon,hi3660-dw-mshc";
-			num-slots = <1>;
 			bus-width = <0x4>;
 			disable-wp;
 			cap-sd-highspeed;
@@ -834,7 +833,6 @@
 			compatible = "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff3ff000 0x0 0x1000>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-			num-slots = <1>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
 				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
 			clock-names = "ciu", "biu";
-- 
1.9.1
