From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 5 Nov 2012 14:42:28 +0530
Subject: [PATCH 7/8] ARM: dts: AM33XX: Add PWMSS device tree nodes
In-Reply-To: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1352106749-9437-8-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
adding necessary properties like pwm-cells, base reg & set disabled as
status.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Second version
	- Combined with HWMOD changes & DT bindings.
	- Handling Parent<-> child relation ship for PWM subsystem

:100644 100644 bb31bff... cf5e049... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |   90 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..cf5e049 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,95 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		epwmss0: epwmss at 48300000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48300000 0x10
+				0x48300100 0x80
+				0x48300180 0x80
+				0x48300200 0x80>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap0: ecap at 48300100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48300100 0x80>;
+				ti,hwmods = "ecap0";
+				status = "disabled";
+			};
+
+			ehrpwm0: ehrpwm at 48300200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48300200 0x80>;
+				ti,hwmods = "ehrpwm0";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
+
+		epwmss1: epwmss at 48302000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48302000 0x10
+				0x48302100 0x80
+				0x48302180 0x80
+				0x48302200 0x80>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap1: ecap at 48302100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48302100 0x80>;
+				ti,hwmods = "ecap1";
+				status = "disabled";
+			};
+
+			ehrpwm1: ehrpwm at 48302200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48302200 0x80>;
+				ti,hwmods = "ehrpwm1";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
+
+		epwmss2: epwmss at 48304000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48304000 0x10
+				0x48304100 0x80
+				0x48304180 0x80
+				0x48304200 0x80>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap2: ecap at 48304100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48304100 0x80>;
+				ti,hwmods = "ecap2";
+				status = "disabled";
+			};
+
+			ehrpwm2: ehrpwm at 48304200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48304200 0x80>;
+				ti,hwmods = "ehrpwm2";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
 	};
 };
-- 
1.7.0.4
