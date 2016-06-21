From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 Jun 2016 12:51:49 -0600
Subject: [PATCH] ARM: tegra: import latest Jetson TK1 spreadsheet
Message-ID: <20160621185149.20625-1-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This imports v11 of "Jetson TK1 Development Platform Pin Mux" from
https://developer.nvidia.com/embedded/downloads.

The new version defines the mux option for the MIPI pad ctrl selection.
The OWR pin no longer has an entry in the configuration table because
the only mux option it support is OWR, that feature isn't supported, and
hence can't conflict with any other pin. This pin can only usefully be
used as a GPIO.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 941f36263c8f..24bab492a9ca 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1356,14 +1356,6 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			owr {
-				nvidia,pins = "owr";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,rcv-sel = <TEGRA_PIN_DISABLE>;
-			};
 			clk_32k_in {
 				nvidia,pins = "clk_32k_in";
 				nvidia,function = "clk";
@@ -1378,6 +1370,10 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
+			dsi_b {
+				nvidia,pins = "mipi_pad_ctrl_dsi_b";
+				nvidia,function = "dsi_b";
+			};
 		};
 	};
 
-- 
2.9.0
