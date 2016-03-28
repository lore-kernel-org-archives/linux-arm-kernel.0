From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 28 Mar 2016 16:21:20 +0000
Subject: [PATCH] ARM: bcm2835: add CPU node for ARM core
Message-ID: <1459182081-30819-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the CPU node of the BCM2835 into the DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index b83b326..e87aba1 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -3,6 +3,17 @@
 / {
 	compatible = "brcm,bcm2835";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,arm1176jzf-s", "arm,arm1176";
+			reg = <0x0>;
+		};
+	};
+
 	soc {
 		ranges = <0x7e000000 0x20000000 0x02000000>;
 		dma-ranges = <0x40000000 0x00000000 0x20000000>;
-- 
1.7.9.5
