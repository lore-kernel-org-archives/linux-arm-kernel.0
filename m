From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:25 +0100
Subject: [PATCH 3/9] arm64: tegra: Add serial ports on Tegra186
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The initial patch only added UARTA, but there's no reason we shouldn't
be adding all of them. While at it, also specify the missing clocks and
resets for UARTA.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 78 ++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index eadbfacd16c2..911f288966ba 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1,5 +1,7 @@
+#include <dt-bindings/clock/tegra186-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
+#include <dt-bindings/reset/tegra186-reset.h>
 
 / {
 	compatible = "nvidia,tegra186";
@@ -12,6 +14,58 @@
 		reg = <0x0 0x03100000 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTA>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTA>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartb: serial at 3110000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03110000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTB>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTB>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartd: serial at 3130000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03130000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTD>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTD>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uarte: serial at 3140000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03140000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTE>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTE>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartf: serial at 3150000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03150000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTF>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTF>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -35,6 +89,30 @@
 		status = "disabled";
 	};
 
+	uartc: serial at c280000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x0c280000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTC>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTC>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartg: serial at c290000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x0c290000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_UARTG>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA186_RESET_UARTG>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
 	sysram at 30000000 {
 		compatible = "nvidia,tegra186-sysram", "mmio-sram";
 		reg = <0x0 0x30000000 0x0 0x50000>;
-- 
2.10.2
