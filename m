From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 17:06:21 +0100
Subject: [PATCH 09/10] ARM: tegra: Add Tegra124 USB support
In-Reply-To: <1387469182-14398-1-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
Message-ID: <1387469182-14398-10-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB controllers on Tegra124 are backwards-compatible with those
found on Tegra30.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 99 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index cf4558257e8c..a2ebe8972ea0 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -677,6 +677,105 @@
 		};
 	};
 
+	usb at 7d000000 {
+		compatible = "nvidia,tegra30-ehci", "usb-ehci";
+		reg = <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USBD>;
+		resets = <&tegra_car 22>;
+		reset-names = "usb";
+		nvidia,phy = <&phy1>;
+		status = "disabled";
+	};
+
+	phy1: usb-phy at 7d000000 {
+		compatible = "nvidia,tegra30-usb-phy";
+		reg = <0x7d000000 0x4000 0x7d000000 0x4000>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USBD>,
+			 <&tegra_car TEGRA124_CLK_PLL_U>,
+			 <&tegra_car TEGRA124_CLK_USBD>;
+		clock-names = "reg", "pll_u", "utmi-pads";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,idle-wait-delay = <17>;
+		nvidia,elastic-limit = <16>;
+		nvidia,term-range-adj = <6>;
+		nvidia,xcvr-setup = <9>;
+		nvidia,xcvr-lsfslew = <0>;
+		nvidia,xcvr-lsrslew = <3>;
+		nvidia,hssquelch-level = <2>;
+		nvidia,hsdiscon-level = <5>;
+		nvidia,xcvr-hsslew = <12>;
+		status = "disabled";
+	};
+
+	usb at 7d004000 {
+		compatible = "nvidia,tegra30-ehci", "usb-ehci";
+		reg = <0x7d004000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USB2>;
+		resets = <&tegra_car 58>;
+		reset-names = "usb";
+		nvidia,phy = <&phy2>;
+		status = "disabled";
+	};
+
+	phy2: usb-phy at 7d004000 {
+		compatible = "nvidia,tegra30-usb-phy";
+		reg = <0x7d004000 0x4000 0x7d000000 0x4000>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USB2>,
+			 <&tegra_car TEGRA124_CLK_PLL_U>,
+			 <&tegra_car TEGRA124_CLK_USBD>;
+		clock-names = "reg", "pll_u", "utmi-pads";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,idle-wait-delay = <17>;
+		nvidia,elastic-limit = <16>;
+		nvidia,term-range-adj = <6>;
+		nvidia,xcvr-setup = <9>;
+		nvidia,xcvr-lsfslew = <0>;
+		nvidia,xcvr-lsrslew = <3>;
+		nvidia,hssquelch-level = <2>;
+		nvidia,hsdiscon-level = <5>;
+		nvidia,xcvr-hsslew = <12>;
+		status = "disabled";
+	};
+
+	usb at 7d008000 {
+		compatible = "nvidia,tegra30-ehci", "usb-ehci";
+		reg = <0x7d008000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USB3>;
+		resets = <&tegra_car 59>;
+		reset-names = "usb";
+		nvidia,phy = <&phy3>;
+		status = "disabled";
+	};
+
+	phy3: usb-phy at 7d008000 {
+		compatible = "nvidia,tegra30-usb-phy";
+		reg = <0x7d008000 0x4000 0x7d000000 0x4000>;
+		phy_type = "utmi";
+		clocks = <&tegra_car TEGRA124_CLK_USB3>,
+			 <&tegra_car TEGRA124_CLK_PLL_U>,
+			 <&tegra_car TEGRA124_CLK_USBD>;
+		clock-names = "reg", "pll_u", "utmi-pads";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,idle-wait-delay = <17>;
+		nvidia,elastic-limit = <16>;
+		nvidia,term-range-adj = <6>;
+		nvidia,xcvr-setup = <9>;
+		nvidia,xcvr-lsfslew = <0>;
+		nvidia,xcvr-lsrslew = <3>;
+		nvidia,hssquelch-level = <2>;
+		nvidia,hsdiscon-level = <5>;
+		nvidia,xcvr-hsslew = <12>;
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.4.2
