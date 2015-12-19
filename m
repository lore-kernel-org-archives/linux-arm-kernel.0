From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 20 Dec 2015 01:32:11 +0200
Subject: [PATCH 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <1450567932-22994-1-git-send-email-vz@mleia.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
Message-ID: <1450567932-22994-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds fixed voltage regulator for SD controller, ARM MMCI
controller driver uses it to control card power management.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/phy3250.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 34e15fd..5465b9e 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -45,6 +45,15 @@
 			enable-active-high;
 			regulator-boot-on;
 		};
+
+		sd_reg: fixed-regulator at 2 {
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
+				vqmmc-supply = <&sd_reg>;
 				status = "okay";
 			};
 		};
-- 
2.1.4
