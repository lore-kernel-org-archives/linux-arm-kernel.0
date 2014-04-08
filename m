From: denis@eukrea.com (Denis Carikli)
Date: Tue,  8 Apr 2014 18:22:41 +0200
Subject: [PATCH v11][ 1/2] ARM: dts: cpuimx35 Add touchscreen support.
Message-ID: <1396974162-16535-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v10->v11:
- Moved the Cc to git-send-email.
- Rebased (pingrp are now gone).

ChangeLog v8->v10:
- Reduced Cc list, not to bother unrelated subsystem maintainers.
- Added the pinctrl node (because it is not anymore in the patch adding the cpuimx35).
- Cosmetic fix: reordered the tsc2007 node properties.

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index 906ae93..9c2b715 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -37,6 +37,17 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		gpios = <&gpio3 2 0>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <0x2 0x8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		reg = <0x48>;
+		ti,x-plate-ohms = <180>;
+	};
 };
 
 &iomuxc {
@@ -70,6 +81,10 @@
 				MX35_PAD_I2C1_DAT__I2C1_SDA		0x80000000
 			>;
 		};
+
+		pinctrl_tsc2007_1: tsc2007grp-1 {
+			fsl,pins = <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
+		};
 	};
 };
 
-- 
1.7.9.5
