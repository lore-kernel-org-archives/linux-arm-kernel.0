From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 31 Jul 2018 13:38:07 +0800
Subject: [PATCH v4 10/10] dts: arm64: mt8183: add uart node
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1533015487-60189-11-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add uart node with correct uart clocks.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  8 ++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 30 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 2a3dd5a..9b52559 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -12,6 +12,10 @@
 	model = "MediaTek MT8183 evaluation board";
 	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
 	memory at 40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
@@ -21,3 +25,7 @@
 		stdout-path = "serial0:921600n8";
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 6b87a24..c22a2dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -170,6 +170,36 @@
 		#clock-cells = <1>;
 	};
 
+	uart0: serial at 11002000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11002000 0 0x1000>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart1: serial at 11003000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x1000>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart2: serial at 11004000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11004000 0 0x1000>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART2>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
 	audiosys: syscon at 11220000 {
 		compatible = "mediatek,mt8183-audiosys", "syscon";
 		reg = <0 0x11220000 0 0x1000>;
-- 
1.9.1
