From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Mar 2017 18:34:55 -0500
Subject: [PATCH] ARM: dts: NSP: disable i2c DT entry by default
Message-ID: <1488929695-30428-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c device tree entry should be disabled by default to match the
current convention in other device tree files.  Similarily, enable it on
the XMC board, where it is being used.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 1 +
 arch/arm/boot/dts/bcm958525xmc.dts | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 832795b..3c6a34a6 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -347,6 +347,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 			clock-frequency = <100000>;
+			status = "disabled";
 		};
 
 		watchdog at 39000 {
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 41e7fd3..5081cd1 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -66,6 +66,8 @@
 };
 
 &i2c0 {
+	status = "okay";
+
 	temperature-sensor at 4c {
 		compatible = "adi,adt7461a";
 		reg = <0x4c>;
-- 
2.7.4
