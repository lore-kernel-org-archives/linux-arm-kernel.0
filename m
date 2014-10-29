From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 29 Oct 2014 15:50:13 +0100
Subject: [PATCH 3/3] ARM: tegra: Add Tegra124 ACTMON support
In-Reply-To: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1414594232-15684-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for the ACTMON block to the Tegra124 device tree.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index b1ec35e..8bce1b3 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -213,6 +213,17 @@
 		reg = <0x0 0x60007000 0x0 0x1000>;
 	};
 
+	actmon at 0,6000c800 {
+		compatible = "nvidia,tegra124-actmon";
+		reg = <0x0 0x6000c800 0x0 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
+			 <&tegra_car TEGRA124_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car 119>;
+		reset-names = "actmon";
+	};
+
 	gpio: gpio at 0,6000d000 {
 		compatible = "nvidia,tegra124-gpio", "nvidia,tegra30-gpio";
 		reg = <0x0 0x6000d000 0x0 0x1000>;
-- 
1.9.3
