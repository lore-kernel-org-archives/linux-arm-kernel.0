From: matt.porter@linaro.org (Matt Porter)
Date: Thu,  6 Jun 2013 01:41:35 -0400
Subject: [PATCH 2/2] ARM: dts: bcm281xx: use existing defines for irqs
In-Reply-To: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
References: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1370497295-12682-3-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the standard interrupt-controller and ARM GIC constants to
improve the readability of bcm281xx DT irq properties.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index c08810e..824bebe 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -11,6 +11,9 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 #include "skeleton.dtsi"
 
 / {
@@ -41,7 +44,7 @@
 		status = "disabled";
 		reg = <0x3e000000 0x1000>;
 		clock-frequency = <13000000>;
-		interrupts = <0x0 67 0x4>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 	};
@@ -56,7 +59,7 @@
 	timer at 35006000 {
 		compatible = "bcm,kona-timer";
 		reg = <0x35006000 0x1000>;
-		interrupts = <0x0 7 0x4>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <32768>;
 	};
 
-- 
1.7.9.5
