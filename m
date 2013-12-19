From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:27 +0100
Subject: [PATCH 03/10] ARM: tegra: Add MIPI calibration DT entries for Tegra114
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-4-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the MIPI calibration block on Tegra114. There is
no need to disable it by default because it only enables the clock while
performing calibration and therefore shouldn't be consuming any power
when unused.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- update for revised bindings

Changes in v2:
- remove include/dt-bindings/gpu/host1x/tegra114-mipi.h

 arch/arm/boot/dts/tegra114.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index ae855ec60bbd..9a40a3fc37ec 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -480,6 +480,13 @@
 		};
 	};
 
+	mipi: mipi {
+		compatible = "nvidia,tegra114-mipi";
+		reg = <0x700e3000 0x100>;
+		clocks = <&tegra_car TEGRA114_CLK_MIPI_CAL>;
+		#nvidia,mipi-calibrate-cells = <1>;
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
-- 
1.8.4.2
