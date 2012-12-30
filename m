From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:03 -0600
Subject: [PATCH 2/6] ARM: dts: fix highbank cpu mpidr values
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With the addition of commit a0ae0240 (ARM: kernel: add device tree init
map function), the cpu reg values must match the cpu mpidr register or we'll
get warnings. For some reason, the CLUSTERID on highbank is 9, so the reg
value needs to be 0x90n to quiet the warnings.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/highbank.dts |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 81e0bfa..5927a8d 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -30,37 +30,37 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu at 900 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x900>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
 		};
 
-		cpu at 1 {
+		cpu at 901 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
-			reg = <1>;
+			reg = <0x901>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
 		};
 
-		cpu at 2 {
+		cpu at 902 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
-			reg = <2>;
+			reg = <0x902>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
 		};
 
-		cpu at 3 {
+		cpu at 903 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
-			reg = <3>;
+			reg = <0x903>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
-- 
1.7.10.4
