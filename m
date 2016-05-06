From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:24 -0700
Subject: [PATCH 5/7] ARM64: dts: amlogic: add pins for EMMC, SD
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-6-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 35397fcc5380..7b22b9d3b9d9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -213,6 +213,27 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
+
+				emmc_pins: emmc {
+					mux {
+						groups = "emmc_nand_d07",
+						       "emmc_cmd",
+						       "emmc_clk";
+						function = "emmc";
+					};
+				};
+
+				sdcard_pins: sdcard {
+					mux {
+						groups = "sdcard_d0",
+						       "sdcard_d1",
+						       "sdcard_d2",
+						       "sdcard_d3",
+						       "sdcard_cmd",
+						       "sdcard_clk";
+						function = "sdcard";
+					};
+				};
 			};
 		};
 
-- 
2.7.4
