From: wni@nvidia.com (Wei Ni)
Date: Wed, 4 Jul 2012 17:34:47 +0800
Subject: [PATCH 4/5] ARM: dt: t30 cardhu: add pinmux, gpio for wlan
In-Reply-To: <1341394488-13169-1-git-send-email-wni@nvidia.com>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
Message-ID: <1341394488-13169-5-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds wlan pinmux and gpio settings to the Tegra30 Cardhu device tree.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dts |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dts b/arch/arm/boot/dts/tegra30-cardhu.dts
index c169bce..08749cc 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu.dts
@@ -31,6 +31,22 @@
 				nvidia,pull = <2>;
 				nvidia,tristate = <0>;
 			};
+			sdmmc3_clk_pa6 {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc3_cmd_pa7 {
+				nvidia,pins =	"sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
 			sdmmc4_clk_pcc4 {
 				nvidia,pins =	"sdmmc4_clk_pcc4",
 						"sdmmc4_rst_n_pcc3";
@@ -60,6 +76,15 @@
 				nvidia,pull = <0>;
 				nvidia,tristate = <0>;
 			};
+			sdio3 {
+				nvidia,pins = "drive_sdio3";
+				nvidia,high-speed-mode = <0>;
+				nvidia,schmitt = <0>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <1>;
+				nvidia,slew-rate-falling = <1>;
+			};
 		};
 	};
 
@@ -142,6 +167,11 @@
 		bus-width = <4>;
 	};
 
+	sdhci at 78000400 {
+		status = "okay";
+		power-gpios = <&gpio 28 0>; /* gpio PD4 */
+	};
+
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
-- 
1.7.1
