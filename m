From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:44 +0800
Subject: [PATCH 03/10] arm64: dts: zx296718: add pinctrl and gpio devices
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds pinctrl and gpio devices for zx296718 SoC support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 37eb93a39c92..53bd504b4400 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -53,6 +53,13 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		gpio0 = &bgpio0;
+		gpio1 = &bgpio1;
+		gpio2 = &bgpio2;
+		gpio3 = &bgpio3;
+		gpio4 = &bgpio4;
+		gpio5 = &bgpio5;
+		gpio6 = &bgpio6;
 		serial0 = &uart0;
 	};
 
@@ -288,6 +295,11 @@
 			reg = <0x116000 0x1000>;
 		};
 
+		iocfg: pin-controller at 119000 {
+			compatible = "zte,zx296718-iocfg";
+			reg = <0x119000 0x1000>;
+		};
+
 		uart0: uart at 11f000 {
 			compatible = "arm,pl011", "arm,primecell";
 			arm,primecell-periphid = <0x001feffe>;
@@ -360,6 +372,93 @@
 			#clock-cells = <1>;
 		};
 
+		bgpio0: gpio at 142d000 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d000 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 48 16>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio1: gpio at 142d040 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 80 16>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio2: gpio at 142d080 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d080 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 80 3
+				       &pmm 3 32 4
+				       &pmm 7 83 9>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio3: gpio at 142d0c0 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d0c0 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 92 16>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio4: gpio at 142d100 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d100 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 108 12
+				       &pmm 12 121 4>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio5: gpio at 142d140 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d140 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 125 16>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		bgpio6: gpio at 142d180 {
+			compatible = "zte,zx296718-gpio", "zte,zx296702-gpio";
+			reg = <0x142d180 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmm 0 141 2>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		lsp1crm: clock-controller at 1430000 {
 			compatible = "zte,zx296718-lsp1crm";
 			reg = <0x01430000 0x1000>;
@@ -423,6 +522,12 @@
 			#clock-cells = <1>;
 		};
 
+		pmm: pin-controller at 1462000 {
+			compatible = "zte,zx296718-pmm";
+			reg = <0x1462000 0x1000>;
+			zte,auxiliary-controller = <&iocfg>;
+		};
+
 		sysctrl: sysctrl at 1463000 {
 			compatible = "zte,zx296718-sysctrl", "syscon";
 			reg = <0x1463000 0x1000>;
-- 
1.9.1
