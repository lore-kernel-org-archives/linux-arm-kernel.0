From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 10:51:11 +0200
Subject: [PATCH 2/4] arm: mxs: add lradc to cfa10036
In-Reply-To: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372236673-20725-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lradc is actually available on the Crystalfontz cfa-10036.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 4 ++++
 arch/arm/boot/dts/imx28-cfa10049.dts | 1 -
 arch/arm/boot/dts/imx28-cfa10055.dts | 1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 5e5213f..802e0e9 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -94,6 +94,10 @@
 			usbphy0: usbphy at 8007c000 {
 				status = "okay";
 			};
+
+			lradc at 80050000 {
+				status = "okay";
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index c26676b..4d3c0a6 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -215,7 +215,6 @@
 			};
 
 			lradc at 80050000 {
-				status = "okay";
 				fsl,lradc-touchscreen-wires = <4>;
 			};
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index 1581112..e0de1aa 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -136,7 +136,6 @@
 		apbx at 80040000 {
 			lradc at 80050000 {
 				fsl,lradc-touchscreen-wires = <4>;
-				status = "okay";
 			};
 
 			pwm: pwm at 80064000 {
-- 
1.8.1.2
