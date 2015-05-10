From: dev@lynxeye.de (Lucas Stach)
Date: Sun, 10 May 2015 20:30:01 +0200
Subject: [Patch v3 4/5] ARM: tegra: add Tegra20 NAND flash controller node
In-Reply-To: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
Message-ID: <1431282602-7137-5-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic controller description to be extended
by individual boards.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/tegra20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index adf6b04..8264cb1 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -373,6 +373,19 @@
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
