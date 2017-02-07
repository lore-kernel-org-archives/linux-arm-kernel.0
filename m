From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Tue,  7 Feb 2017 17:56:06 +0200
Subject: [PATCH 2/2] ARM: dts: imx: update snvs-poweroff mask
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <1486482966-4497-2-git-send-email-guy.shapiro@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the syscon-poweroff driver change only the shutdown bits on the
SNVS_LP control register.

This change fixes an issue with the RTC wakeup alarm, that was
previously disabled during power off.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..06984b1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -757,6 +757,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..58717d3 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -644,6 +644,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..be142ed5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -698,6 +698,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7..505d24e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -606,6 +606,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8ff2cbdd..aadb1134 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -529,6 +529,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 				};
 
-- 
2.1.4
