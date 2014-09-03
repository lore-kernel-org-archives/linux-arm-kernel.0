From: nm@ti.com (Nishanth Menon)
Date: Wed, 3 Sep 2014 11:03:10 -0500
Subject: [PATCH] ARM: dts: am335x-bone*: Fix model name and update
 compatibility information
Message-ID: <1409760190-17275-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beaglebone white and beaglebone black differ in tiny little aspects.
This is the reason why we maintain seperate dts for these platforms.
However, there is no real way to decode from dtb which platform it is
since compatible and model name are the same for both platforms.

Fix this so that beaglebone black and beaglebone are identifiable,
while maintaining compatibility for older zImages which might use old
beaglebone compatible flag for black as well.

Reported-by: Tom Rini <trini@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on v3.17-rc1:
Before:
beaglebone-black:  Boot PASS: http://paste.ubuntu.org.cn/1473558
beaglebone:  Boot PASS: http://paste.ubuntu.org.cn/1473559

After:
beaglebone-black:  Boot PASS: http://paste.ubuntu.org.cn/1473480
beaglebone:  Boot PASS: http://paste.ubuntu.org.cn/1473481

Side notes: Sorry, new IT policies, new paste website needed :(

 arch/arm/boot/dts/am335x-bone-common.dtsi |    3 ---
 arch/arm/boot/dts/am335x-bone.dts         |    5 +++++
 arch/arm/boot/dts/am335x-boneblack.dts    |    5 +++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bde1777..d9d9869 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -7,9 +7,6 @@
  */
 
 / {
-	model = "TI AM335x BeagleBone";
-	compatible = "ti,am335x-bone", "ti,am33xx";
-
 	cpus {
 		cpu at 0 {
 			cpu0-supply = <&dcdc2_reg>;
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 94ee427..83d40f7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -10,6 +10,11 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+/ {
+	model = "TI AM335x BeagleBone";
+	compatible = "ti,am335x-bone", "ti,am33xx";
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d..901739f 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -10,6 +10,11 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+/ {
+	model = "TI AM335x BeagleBone Black";
+	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
1.7.9.5
