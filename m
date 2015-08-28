From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:39 +0200
Subject: [PATCH 04/11] arm: tegra: colibri_t30: add pin muxing for on-module
 power i2c
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-5-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin muxing for the on-module power I2C bus which connects to the
PMICs, temperature sensor and touch screen controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 074123f..4ddccfa 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -159,6 +159,18 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Power I2C (On-module) */
+			pwr_i2c_scl_pz6 {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+					      "pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
 			/*
 			 * THERMD_ALERT#, unlatched I2C address pin of LM95245
 			 * temperature sensor therefore requires disabling for
-- 
2.4.3
