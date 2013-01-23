From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 17:28:23 -0700
Subject: [PATCH 2/2] ARM: tegra: add clocks properties to USB PHY nodes
In-Reply-To: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
References: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1358900903-27654-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The patch to add USB PHY nodes to device tree was written before Tegra
supported the clocks property in device tree. Now that it does, add the
required clocks properties to these nodes.

This will allow all clk_get_sys() calls in tegra_usb_phy.c to be replaced
by clk_get(phy->dev, clock_name), as part of converting the PHY driver to
a platform driver.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 2e9d1f0..d5e72ce 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -442,18 +442,24 @@
 		reg = <0xc5000400 0x3c00>;
 		phy_type = "utmi";
 		nvidia,has-legacy-mode;
+		clocks = <&tegra_car 22>, <&tegra_car 127>;
+		clock-names = "utmi", "pll_u";
 	};
 
 	phy2: usb-phy at c5004400 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5004400 0x3c00>;
 		phy_type = "ulpi";
+		clocks = <&tegra_car 94>, <&tegra_car 127>;
+		clock-names = "ulpi", "pll_u";
 	};
 
 	phy3: usb-phy at c5008400 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5008400 0x3C00>;
 		phy_type = "utmi";
+		clocks = <&tegra_car 22>, <&tegra_car 127>;
+		clock-names = "utmi", "pll_u";
 	};
 
 	usb at c5000000 {
-- 
1.7.10.4
