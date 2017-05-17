From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 17 May 2017 16:37:43 +0800
Subject: [PATCH 10/12] arm64: dts: hi3660: add spi device nodes
In-Reply-To: <20170517083745.24479-1-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
Message-ID: <20170517083745.24479-11-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

Add spi2 and spi3 device nodes for hi3660, and enable them for hikey960.

On HiKey960:
 - SPI2 is wired out through low speed expansion connector.
 - SPI3 is wired out through high speed expansion connector.

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  8 ++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 30 +++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 69aa207..79735ee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -69,3 +69,11 @@
 &uart6 {
 	status = "okay";
 };
+
+&spi2 {
+	status = "okay";
+};
+
+&spi3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c2bca5d..48da97f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -728,5 +728,35 @@
 			clock-names = "apb_pclk";
 			status = "ok";
 		};
+
+		spi2: spi at ffd68000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xffd68000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI2>;
+			clock-names = "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_pmx_func>;
+			num-cs = <1>;
+			cs-gpios = <&gpio27 2 0>;
+			status = "disabled";
+		};
+
+		spi3: spi at ff3b3000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xff3b3000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SPI3>;
+			clock-names = "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi3_pmx_func>;
+			num-cs = <1>;
+			cs-gpios = <&gpio18 5 0>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.10.2
