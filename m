From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:51 +0100
Subject: [PATCH v3 02/19] ARM: dts: armada-370-xp: move the cpurst node in the
 common file
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpurst nodes are identical in armada-370.dtsi and armada-xp.dtsi
files, so move it in the common armada-370-xp.dtsi file.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 -----
 arch/arm/boot/dts/armada-xp.dtsi     | 1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 3ccedc9dffb2..1d8171380fa0 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -228,6 +228,11 @@
 				reg = <0x20300 0x34>, <0x20704 0x4>;
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x8>;
+			};
+
 			pmsu at 22000 {
 				compatible = "marvell,armada-370-pmsu";
 				reg = <0x22000 0x1000>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index b4258105e91f..79b5463209aa 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -233,11 +233,6 @@
 				clocks = <&coreclk 2>;
 			};
 
-			cpurst at 20800 {
-				compatible = "marvell,armada-370-cpu-reset";
-				reg = <0x20800 0x8>;
-			};
-
 			cpu-config at 21000 {
 				compatible = "marvell,armada-370-cpu-config";
 				reg = <0x21000 0x8>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 4a5f99e65b51..e141de2a4a1c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -167,7 +167,6 @@
 			};
 
 			cpurst at 20800 {
-				compatible = "marvell,armada-370-cpu-reset";
 				reg = <0x20800 0x20>;
 			};
 
-- 
2.10.2
