From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Mar 2015 16:35:55 -0800
Subject: [PATCH v5 7/8] ARM: dts: enable GPIO for Broadcom Cygnus
In-Reply-To: <1425515756-321-1-git-send-email-rjui@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425515756-321-8-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables all 3 GPIO controllers including the ASIU GPIO, the
chipcommonG GPIO, and the ALWAYS-ON GPIO, for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Dmitry Torokhov <dtor@chromium.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1cbae6a..8d247d2 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -60,6 +60,39 @@
 		      <0x0301d24c 0x2c>;
 	};
 
+	gpio_crmu: gpio at 03024800 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x03024800 0x50>,
+		      <0x03024008 0x18>;
+		ngpios = <6>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio_ccm: gpio at 1800a000 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x1800a000 0x50>,
+		      <0x0301d164 0x20>;
+		ngpios = <24>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+	};
+
+	gpio_asiu: gpio at 180a5000 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x180a5000 0x668>;
+		ngpios = <146>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		pinmux = <&pinctrl>;
+
+		interrupt-controller;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
