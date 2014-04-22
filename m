From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 22 Apr 2014 10:27:27 +0200
Subject: [PATCH v2 1/2] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
In-Reply-To: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1398155248-1659-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SDHCI nodes for the Marvell Berlin BG2Q, using the mrvl,pxav3-mmc
driver.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 5925e6a16749..85d0ca5cc47a 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -67,6 +67,14 @@
 		clock-div = <3>;
 	};
 
+	sdio1clk: sdio1clk {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&syspll>;
+		clock-mult = <1>;
+		clock-div = <4>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -75,6 +83,30 @@
 		ranges = <0 0xf7000000 0x1000000>;
 		interrupt-parent = <&gic>;
 
+		sdhci0: sdhci at ab0000 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab0000 0x200>;
+			clocks = <&sdio1clk>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci at ab0800 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab0800 0x200>;
+			clocks = <&sdio1clk>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sdhci2: sdhci at ab1000 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab1000 0x200>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdio1clk>;
+			status = "disabled";
+		};
+
 		l2: l2-cache-controller at ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
-- 
1.8.3.2
