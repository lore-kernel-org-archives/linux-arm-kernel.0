From: m.niestroj@grinn-global.com (Marcin Niestroj)
Date: Tue,  4 Jul 2017 18:19:12 +0200
Subject: [RESEND PATCH] ARM: dts: imx: update snvs-poweroff mask
Message-ID: <20170704161912.29618-1-m.niestroj@grinn-global.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guy Shapiro <guy.shapiro@mobi-wize.com>

Make the syscon-poweroff driver change only the shutdown bits on the
SNVS_LP control register.

This change fixes an issue with the RTC wakeup alarm, that was
previously disabled during power off.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
Hi,

This is a resend of second patch from patch series [1]. First patch is already
in v4.12, but this one was not applied.

Tested on imx6ul board. Without that patch RTC time is "frozen" during
power-down state. With that patch RTC shows proper time after exiting
from power-down.

[1] https://www.spinics.net/lists/arm-kernel/msg561152.html

 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e426faa9c243..f81f38700c88 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -766,6 +766,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index cc9572ea2860..2c2a90f2c8fc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -652,6 +652,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 3f1416be4c36..a7c6ca1638c6 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -707,6 +707,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d09402..d3431a796716 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -613,6 +613,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c4f12fd2e044..216fbcb13bf5 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -535,6 +535,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 				};
 
-- 
2.13.2
