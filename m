From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 17 Aug 2015 10:05:25 +0800
Subject: [PATCH] arm64: dts: Juno: fix the wrong memory map sizes for the
 I2C/EHCI/OHCI
Message-ID: <1439777125-9409-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the "Juno ARM Development Platform Soc Techinical Reference Mannual(r1p0)",
we get the following memory map sizes (3-25):
	I2C      : 0x7ffa0000  0x7ffa00ff       (256B)
	USB OHCI : 0x7ffb0000  0x7ffb0fff       (4KB)
	USB EHCI : 0x7ffc0000  0x7ffc0fff       (4KB)

This patch fixes the wrong memory map sizes for them.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index e3ee960..7b2715f 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -74,7 +74,7 @@
 
 	i2c at 7ffa0000 {
 		compatible = "snps,designware-i2c";
-		reg = <0x0 0x7ffa0000 0x0 0x1000>;
+		reg = <0x0 0x7ffa0000 0x0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
@@ -95,14 +95,14 @@
 
 	ohci at 7ffb0000 {
 		compatible = "generic-ohci";
-		reg = <0x0 0x7ffb0000 0x0 0x10000>;
+		reg = <0x0 0x7ffb0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&soc_usb48mhz>;
 	};
 
 	ehci at 7ffc0000 {
 		compatible = "generic-ehci";
-		reg = <0x0 0x7ffc0000 0x0 0x10000>;
+		reg = <0x0 0x7ffc0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&soc_usb48mhz>;
 	};
-- 
2.1.4
