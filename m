From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed,  4 Jun 2014 17:16:29 +0200
Subject: [PATCH 3/4] ARM: tegra: tegra124: Add XUSB pad controller
In-Reply-To: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
References: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1401894990-30092-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The device tree node in the SoC file contains only the resources (such
as registers, resets, ...) but none of the lane assignment information
since that's board specific and belongs in the board file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 6e6bc4e8185c..38cb06fd693b 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -449,6 +449,17 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	padctl at 0,7009f000 {
+		compatible = "nvidia,tegra124-xusb-padctl";
+		reg = <0x0 0x7009f000 0x0 0x1000>;
+		resets = <&tegra_car 142>;
+		reset-names = "padctl";
+
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#phy-cells = <1>;
+	};
+
 	sdhci at 0,700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
-- 
1.9.2
