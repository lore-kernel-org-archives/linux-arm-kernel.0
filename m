From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 13:45:01 -0700
Subject: [PATCH v6 7/8] ARM: dts: enable GPIO for Broadcom Cygnus
In-Reply-To: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425933902-20652-8-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables all 3 GPIO controllers including the ASIU GPIO, the
chipcommonG GPIO, and the ALWAYS-ON GPIO, for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Dmitry Torokhov <dtor@chromium.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1cbae6a..63b7fed 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -60,6 +60,36 @@
 		      <0x0301d24c 0x2c>;
 	};
 
+	gpio_crmu: gpio at 03024800 {
+		compatible = "brcm,cygnus-crmu-gpio";
+		reg = <0x03024800 0x50>,
+		      <0x03024008 0x18>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio_ccm: gpio at 1800a000 {
+		compatible = "brcm,cygnus-ccm-gpio";
+		reg = <0x1800a000 0x50>,
+		      <0x0301d164 0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+	};
+
+	gpio_asiu: gpio at 180a5000 {
+		compatible = "brcm,cygnus-asiu-gpio";
+		reg = <0x180a5000 0x668>;
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
