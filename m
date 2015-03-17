From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 17 Mar 2015 10:36:18 +0100
Subject: [PATCH v6 8/8] ARM: tegra: Add Tegra124 ACTMON support
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426584991-11110-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for the ACTMON block to the Tegra124 device tree.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

---

v6:	* Remove operating-points property

v2:	* Add operating-points property
---
 arch/arm/boot/dts/tegra124.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index a49e7da..2158aa9 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -215,6 +215,17 @@
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
2.1.0
