From: liwei213@huawei.com (Li Wei)
Date: Fri, 13 Oct 2017 15:49:34 +0800
Subject: [PATCH v4 3/5] arm64: dts: add ufs dts node
In-Reply-To: <20171013074936.97284-1-liwei213@huawei.com>
References: <20171013074936.97284-1-liwei213@huawei.com>
Message-ID: <20171013074936.97284-4-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: add ufs node for Hisilicon.

Signed-off-by: Li Wei <liwei213@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  5 +++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index fd4705c451e2..457645a2b53f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -276,3 +276,8 @@
 		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
 	};
 };
+
+&ufs {
+	reset-gpio = <&gpio18 1 0>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index b7a90d632959..a24ab8472347 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -978,5 +978,24 @@
 			clocks = <&crg_ctrl HI3660_OSC32K>;
 			clock-names = "apb_pclk";
 		};
+
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
+			clock-names = "clk_ref", "clk_phy";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			/* offset: 0x84; bit: 7  */
+			resets = <&crg_rst 0x84 12>,
+				<&crg_rst 0x84 7>;
+			reset-names = "rst", "assert";
+		};
 	};
 };
-- 
2.11.0
