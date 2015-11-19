From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Thu, 19 Nov 2015 16:37:09 +0800
Subject: [PATCH V2 2/2] arm64: dts: add Hi6220 spi configuration nodes
In-Reply-To: <1447922229-60552-1-git-send-email-zhongkaihua@huawei.com>
References: <1447922229-60552-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1447922229-60552-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: add Hi6220 spi configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |  1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 4fb0bdc..2313ae0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -23,6 +23,7 @@
 		serial1 = &uart1; /* BT UART */
 		serial2 = &uart2; /* LS Expansion UART0 */
 		serial3 = &uart3; /* LS Expansion UART1 */
+		spi0 = &spi_0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 0f11e2a..da0fe37 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -489,5 +489,25 @@
 			clock-names = "apb_pclk";
 			status = "ok";
 		};
+
+		spi_0: spi at f7106000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xf7106000 0x0 0x1000>;
+			interrupts = <0 50 4>;
+			bus-id = <0>;
+			enable-dma = <0>;
+			/*dmas = <&dma0 12 &dma0 13>;*/
+			/*dma-names = "rx", "tx";*/
+
+			clocks = <&sys_ctrl HI6220_SPI_CLK>;
+			clock-names = "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
+			num-cs = <1>;
+			cs-gpios = <&gpio6 2 0>;
+
+			status = "ok";
+		};
+
 	};
 };
-- 
1.9.1
