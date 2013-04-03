From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  3 Apr 2013 16:45:14 +0200
Subject: [PATCH v3 08/12] ARM: tegra: tamonten: Add PCIe support
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1365000318-28256-9-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties common to all Tamonten-derived boards to the Tamonten
DTSI and add the fixed 1.05 V regulator.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- add properties common to all Tamonten boards
- add fixed 1.05 V regulator

 arch/arm/boot/dts/tegra20-tamonten.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 08cc557..020f7bc 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -438,7 +438,7 @@
 					regulator-always-on;
 				};
 
-				ldo0 {
+				pci_clk_reg: ldo0 {
 					regulator-name = "vdd_ldo0,vddio_pex_clk";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -533,6 +533,11 @@
 		nvidia,invert-interrupt;
 	};
 
+	pcie-controller {
+		pex-clk-supply = <&pci_clk_reg>;
+		vdd-supply = <&pci_vdd_reg>;
+	};
+
 	usb at c5008000 {
 		status = "okay";
 	};
@@ -558,5 +563,15 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
 		};
+
+		pci_vdd_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_1v05";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			gpio = <&pmic 2 0>;
+			enable-active-high;
+		};
 	};
 };
-- 
1.8.2
