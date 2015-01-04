From: dev@lynxeye.de (Lucas Stach)
Date: Sun,  4 Jan 2015 21:39:19 +0100
Subject: [PATCH 3/4] ARM: tegra: add Tegra20 NAND flash controller node
In-Reply-To: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
Message-ID: <1420403960-26626-3-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic controller description to be extended
by individual boards.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/tegra20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8acf5d8..090e9e4 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -360,6 +360,19 @@
 		status = "disabled";
 	};
 
+	nand: nand at 70008000 {
+		compatible = "nvidia,tegra20-nand";
+		reg = <0x70008000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		clock-names = "nand";
+		resets = <&tegra_car 13>;
+		reset-names = "nand";
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
 	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.1.0
