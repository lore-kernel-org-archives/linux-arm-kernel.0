From: dmurphy@ti.com (Dan Murphy)
Date: Fri, 31 May 2013 10:45:22 -0500
Subject: [PATCH v1] ARM: dts: omap4-panda: Update the twl6040 gpio to macro
 definition
Message-ID: <1370015122-26792-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the dt property ti,audpwron-gpio to use the
gpio macro definition for GPIO_ACTIVE_HIGH.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 800fa4e..00cbaa5 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -190,7 +190,7 @@
 		/* IRQ# = 119 */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
-		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
+		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
 		v2v1-supply = <&v2v1>;
-- 
1.7.5.4
