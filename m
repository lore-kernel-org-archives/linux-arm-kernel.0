From: liwei213@huawei.com (Li Wei)
Date: Fri, 25 May 2018 17:17:10 +0800
Subject: [PATCH v10 3/5] arm64: dts: add ufs dts node
In-Reply-To: <20180525091712.37227-1-liwei213@huawei.com>
References: <20180525091712.37227-1-liwei213@huawei.com>
Message-ID: <20180525091712.37227-4-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: add ufs node for Hisilicon.

Signed-off-by: Li Wei <liwei213@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ec3eb8e33a3a..04438621c6c3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -892,6 +892,24 @@
 			reset-gpios = <&gpio11 1 0 >;
 		};
 
+		/* UFS */
+		ufs: ufs at ff3b0000 {
+			compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3b0000 0x0 0x1000>,
+				<0x0 0xff3b1000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
+			clock-names = "ref_clk", "phy_clk";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			resets = <&crg_rst 0x84 12>;
+			reset-names = "rst";
+		};
+
 		/* SD */
 		dwmmc1: dwmmc1 at ff37f000 {
 			#address-cells = <1>;
-- 
2.15.0
