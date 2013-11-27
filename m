From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Wed, 27 Nov 2013 14:14:20 +0100
Subject: [PATCH] ARM: DT: imx6qdl: fix can clocks
Message-ID: <1385558060-20314-1-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

per and ipg clock numbers are exchanged. This leads to
wrong bitrate calculation.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59154dc..797f007 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -329,7 +329,7 @@
 				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02090000 0x4000>;
 				interrupts = <0 110 0x04>;
-				clocks = <&clks 108>, <&clks 109>;
+				clocks = <&clks 109>, <&clks 108>;
 				clock-names = "ipg", "per";
 			};
 
@@ -337,7 +337,7 @@
 				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02094000 0x4000>;
 				interrupts = <0 111 0x04>;
-				clocks = <&clks 110>, <&clks 111>;
+				clocks = <&clks 111>, <&clks 110>;
 				clock-names = "ipg", "per";
 			};
 
-- 
1.7.9.5
