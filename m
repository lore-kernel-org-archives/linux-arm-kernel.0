From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 31 Mar 2016 17:25:17 +0000
Subject: [PATCH V2] ARM: bcm2835: add CPU node for ARM core
Message-ID: <1459445118-1733-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the CPU node of the BCM2835 into the DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

---
 arch/arm/boot/dts/bcm2835.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Changes in V2:
- removed undocumented fallback compatible

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
+			compatible = "arm,arm1176jzf-s";
+			reg = <0x0>;
+		};
+	};
+
 	soc {
 		ranges = <0x7e000000 0x20000000 0x02000000>;
 		dma-ranges = <0x40000000 0x00000000 0x20000000>;
-- 
1.7.9.5
