From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 16:09:31 +0200
Subject: [PATCH v2 03/11] ARM: mvebu: add enable-method property for CPUs
In-Reply-To: <1396620579-15230-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396620579-15230-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396620579-15230-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Armada XP Device Trees (for the three variants
of Armada XP) to declare the "enable-method" property for the CPUs,
which helps operating systems find the appropriate logic to manage the
CPUs, especially to boot secondary CPUs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 98335fb..1257ff1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -27,6 +27,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-xp-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 9480cf8..3396b25 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -29,6 +29,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-xp-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 31ba6d8..6da84bf 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -30,6 +30,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-xp-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
-- 
1.8.3.2
