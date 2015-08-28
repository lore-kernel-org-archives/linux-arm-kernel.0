From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:38 +0200
Subject: [PATCH 03/11] arm: tegra: colibri_t30: improve comment about thermal
 alert pin
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-4-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the comment about the THERMD_ALERT# pin which is the unlatched
I2C address pin of the LM95245 temperature sensor and therefore
requires disabling for now otherwise it won't get detected properly.

While at it also move that pin further down to have it alphabetically
sorted again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 5e6a47e..074123f 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -66,15 +66,6 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			/* Thermal alert, need to be disabled */
-			lcd_dc1_pd2 {
-				nvidia,pins = "lcd_dc1_pd2";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-			};
-
 			/* Colibri MMC */
 			kb_row10_ps2 {
 				nvidia,pins = "kb_row10_ps2";
@@ -167,6 +158,19 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+
+			/*
+			 * THERMD_ALERT#, unlatched I2C address pin of LM95245
+			 * temperature sensor therefore requires disabling for
+			 * now
+			 */
+			lcd_dc1_pd2 {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
 		};
 	};
 
-- 
2.4.3
