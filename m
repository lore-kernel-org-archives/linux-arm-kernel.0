From: liwei213@huawei.com (Li Wei)
Date: Tue, 29 Aug 2017 16:41:14 +0800
Subject: [PATCH v3 3/5] arm64: dts: add ufs dts node
In-Reply-To: <20170829084116.106695-1-liwei213@huawei.com>
References: <20170829084116.106695-1-liwei213@huawei.com>
Message-ID: <20170829084116.106695-4-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: add ufs node for Hisilicon

Signed-off-by: Li Wei <liwei213@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961e8d55..0ae01d7480df 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -848,5 +848,21 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		ufs: ufs at ff3b0000 {
+			compatible = "jedec,ufs-1.1", "hisilicon,hi3660-ufs";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3b0000 0x0 0x1000>,
+				<0x0 0xff3b1000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
+			clock-names = "clk_ref", "clk_phy";
+			freq-table-hz = <0 0>, <0 0>;
+			reset-gpio = <&gpio18 1 0>;
+			status = "okay";
+		};
 	};
 };
-- 
2.11.0
