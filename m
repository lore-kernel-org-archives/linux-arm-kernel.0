From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon,  7 Aug 2017 00:32:10 +0200
Subject: [PATCH 2/3] ARM: dts: bcm283x: Add 32-bit enable method for SMP
In-Reply-To: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1502058731-12462-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing 32-bit enable method for SMP on BCM2836 and
BCM2837. The BCM2837 already has an enabled method, but this one only
works for 64-bit.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2836.dtsi | 1 +
 arch/arm/boot/dts/bcm2837.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index da3deeb..2c26d0b 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -36,6 +36,7 @@
 	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "brcm,bcm2836-smp";
 
 		v7_cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 2d5de6f0..bc1cca5 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -30,6 +30,7 @@
 	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "brcm,bcm2836-smp"; // for ARM 32-bit
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
-- 
2.7.4
