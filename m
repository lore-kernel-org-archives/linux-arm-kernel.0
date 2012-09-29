From: avinashphilip@ti.com (Philip, Avinash)
Date: Sat, 29 Sep 2012 16:05:19 +0530
Subject: [PATCH 1/2] ARM: dts: AM33XX: Add ECAP & EHRPWM device tree nodes
In-Reply-To: <1348914920-30737-1-git-send-email-avinashphilip@ti.com>
References: <1348914920-30737-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1348914920-30737-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ECAP and EHRPWM device tree nodes to AM33XX SoC family
by adding necessary properties like pwm-cells, base reg & set disabled
as status.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
:100644 100644 a9c885a... 736ba0a... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |   48 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a9c885a..736ba0a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -313,5 +313,53 @@
 			ti,hwmods = "timer7";
 			ti,timer-pwm;
 		};
+
+		ecap0: ecap at 48300100 {
+			compatible = "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x48300100 0x80 0x48300000 0x10>;
+			ti,hwmods = "ecap0";
+			status = "disabled";
+		};
+
+		ecap1: ecap at 48302100 {
+			compatible = "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x48302100 0x80 0x48302000 0x10>;
+			ti,hwmods = "ecap1";
+			status = "disabled";
+		};
+
+		ecap2: ecap at 48304100 {
+			compatible = "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x48304100 0x80 0x48304000 0x10>;
+			ti,hwmods = "ecap2";
+			status = "disabled";
+		};
+
+		ehrpwm0: ehrpwm at 48300200 {
+			compatible = "ti,am33xx-ehrpwm";
+			#pwm-cells = <3>;
+			reg = <0x48300200 0x100 0x48300000 0x10>;
+			ti,hwmods = "ehrpwm0";
+			status = "disabled";
+		};
+
+		ehrpwm1: ehrpwm at 48302200 {
+			compatible = "ti,am33xx-ehrpwm";
+			#pwm-cells = <3>;
+			reg = <0x48302200 0x100 0x48302000 0x10>;
+			ti,hwmods = "ehrpwm1";
+			status = "disabled";
+		};
+
+		ehrpwm2: ehrpwm at 48304200 {
+			compatible = "ti,am33xx-ehrpwm";
+			#pwm-cells = <3>;
+			reg = <0x48304200 0x100 0x48304000 0x10>;
+			ti,hwmods = "ehrpwm2";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.0.4
