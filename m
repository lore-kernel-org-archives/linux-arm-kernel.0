From: wni@nvidia.com (Wei Ni)
Date: Fri, 21 Sep 2012 16:54:58 +0800
Subject: [PATCH v2 3/5] ARM: dt: t20 ventana: set pinmux and power for wlan
In-Reply-To: <1348217700-12309-1-git-send-email-wni@nvidia.com>
References: <1348217700-12309-1-git-send-email-wni@nvidia.com>
Message-ID: <1348217700-12309-4-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure pinmux as required for WiFi.
Enable the SDHCI1 controller, which is connectted to the WiFi module.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 3e5952f..d8161fb 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -237,6 +237,16 @@
 					"ld23_22";
 				nvidia,pull = <1>;
 			};
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1";
+				nvidia,high-speed-mode = <0>;
+				nvidia,schmitt = <1>;
+				nvidia,low-power-mode = <3>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <3>;
+				nvidia,slew-rate-falling = <3>;
+			};
 		};
 	};
 
@@ -456,6 +466,12 @@
 		status = "okay";
 	};
 
+	sdhci at c8000000 {
+		status = "okay";
+		power-gpios = <&gpio 86 0>; /* gpio PK6 */
+		bus-width = <4>;
+	};
+
 	sdhci at c8000400 {
 		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
-- 
1.7.1
