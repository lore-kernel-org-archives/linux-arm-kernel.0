From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  7 Feb 2013 10:45:25 +0530
Subject: [PATCH 1/5] ARM: dts: exynos5250-arndale: Add node entry for
 gpio-buttons
Message-ID: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added GPIO buttons DT node to Arndale board file.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series is based on for-next branch of Kukjin Kim's tree
and added on top of the below patch:
https://patchwork.kernel.org/patch/2042451/
---
 arch/arm/boot/dts/exynos5250-arndale.dts |   48 ++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 63572f9..9ce40df 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -119,4 +119,52 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		menu {
+			label = "SW-TACT2";
+			gpios = <&gpx1 4 0 0x10000 2>;
+			linux,code = <139>;
+			gpio-key,wakeup;
+		};
+
+		home {
+			label = "SW-TACT3";
+			gpios = <&gpx1 5 0 0x10000 2>;
+			linux,code = <102>;
+			gpio-key,wakeup;
+		};
+
+		up {
+			label = "SW-TACT4";
+			gpios = <&gpx1 6 0 0x10000 2>;
+			linux,code = <103>;
+			gpio-key,wakeup;
+		};
+
+		down {
+			label = "SW-TACT5";
+			gpios = <&gpx1 7 0 0x10000 2>;
+			linux,code = <108>;
+			gpio-key,wakeup;
+		};
+
+		back {
+			label = "SW-TACT6";
+			gpios = <&gpx2 0 0 0x10000 2>;
+			linux,code = <158>;
+			gpio-key,wakeup;
+		};
+
+		wakeup {
+			label = "SW-TACT7";
+			gpios = <&gpx2 1 0 0x10000 2>;
+			linux,code = <143>;
+			gpio-key,wakeup;
+		};
+	};
 };
-- 
1.7.4.1
