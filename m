From: denis@eukrea.com (Denis Carikli)
Date: Thu, 23 Jul 2015 10:31:12 +0200
Subject: [PATCH v2] ARM: dts: i.MX35: Fix can support.
In-Reply-To: <20150722180434.GA745@pengutronix.de>
References: <20150722180434.GA745@pengutronix.de>
Message-ID: <1437640272-5054-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 3d42a379b6fa5b46058e3302b1802b29f64865bb
("can: flexcan: add 2nd clock to support imx53 and newer")
the can driver requires a dt nodes to have a second clock.
Add them to imx35 to fix probing the flex can driver on the
respective platforms.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx35.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index b6478e9..e6540b5 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -286,8 +286,8 @@
 			can1: can at 53fe4000 {
 				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fe4000 0x1000>;
-				clocks = <&clks 33>;
-				clock-names = "ipg";
+				clocks = <&clks 33>, <&clks 33>;
+				clock-names = "ipg", "per";
 				interrupts = <43>;
 				status = "disabled";
 			};
@@ -295,8 +295,8 @@
 			can2: can at 53fe8000 {
 				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fe8000 0x1000>;
-				clocks = <&clks 34>;
-				clock-names = "ipg";
+				clocks = <&clks 34>, <&clks 34>;
+				clock-names = "ipg", "per";
 				interrupts = <44>;
 				status = "disabled";
 			};
-- 
2.4.5
