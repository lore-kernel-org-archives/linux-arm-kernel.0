From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  7 Feb 2013 10:45:27 +0530
Subject: [PATCH 3/5] ARM: dts: exynos5250-arndale: Add vmmc regulator support
In-Reply-To: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1360214129-4096-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

Added vmmc regulator node to Arndale DT file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index b40a02f..d018fd2 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -280,6 +280,7 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		vmmc-supply = <&mmc_reg>;
 
 		slot at 0 {
 			reg = <0>;
@@ -304,6 +305,7 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		vmmc-supply = <&mmc_reg>;
 
 		slot at 0 {
 			reg = <0>;
@@ -378,4 +380,13 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	mmc_reg: voltage-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_33ON_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpx1 1 0 0 2>;
+		enable-active-high;
+	};
 };
-- 
1.7.4.1
