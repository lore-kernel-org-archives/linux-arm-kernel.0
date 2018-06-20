From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:54:04 +0300
Subject: [PATCH 3/5] arm64: tegra: Add GPIO controller on Tegra194
In-Reply-To: <20180620125406.11906-1-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
Message-ID: <20180620125406.11906-3-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree node for the GPIO controller on Tegra194.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d7f780b06fe2..abe2d688eb65 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -18,6 +18,23 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		gpio: gpio at 2200000 {
+			compatible = "nvidia,tegra194-gpio";
+			reg-names = "security", "gpio";
+			reg = <0x2200000 0x10000>,
+			      <0x2210000 0x10000>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
 		uarta: serial at 3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.16.1
