From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 21 Dec 2015 21:54:26 +0200
Subject: [PATCH v3 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <1450727667-16175-1-git-send-email-vz@mleia.com>
References: <1450727667-16175-1-git-send-email-vz@mleia.com>
Message-ID: <1450727667-16175-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds fixed voltage regulator for SD controller, ARM MMCI
controller driver uses it to control card power management.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v2 to v3:
* use "regulator" as a generic device tree node name of fixed
  regulators, thanks to Sergei Shtylyov

Changes from v1 to v2:
* specify SD card power supply instead of signal power supply,
  thanks to Russell King

 arch/arm/boot/dts/phy3250.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 8ac368f..a00d7ce 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -45,6 +45,15 @@
 			enable-active-high;
 			regulator-boot-on;
 		};
+
+		sd_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "sd_reg";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio 5 5 0>;
+			enable-active-high;
+		};
 	};
 
 	ahb {
@@ -162,6 +171,7 @@
 				cd-gpios = <&gpio 3 1 0>;
 				cd-inverted;
 				bus-width = <4>;
+				vmmc-supply = <&sd_reg>;
 				status = "okay";
 			};
 		};
-- 
2.1.4
