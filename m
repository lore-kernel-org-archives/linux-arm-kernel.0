From: rjui@broadcom.com (Ray Jui)
Date: Thu, 11 Dec 2014 16:05:06 -0800
Subject: [PATCH v5 3/3] ARM: dts: enable GPIO for Broadcom Cygnus
In-Reply-To: <1418342706-14755-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418342706-14755-1-git-send-email-rjui@broadcom.com>
Message-ID: <1418342706-14755-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables all 3 GPIO controllers including the ASIU GPIO, the
chipcommonG GPIO, and the ALWAYS-ON GPIO, for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 5126f9e..35272b7 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -54,6 +54,39 @@
 
 	/include/ "bcm-cygnus-clock.dtsi"
 
+	gpio_ccm: gpio at 1800a000 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x1800a000 0x50>,
+			<0x0301d164 0x20>;
+		ngpios = <24>;
+		linux,gpio-base = <0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+	};
+
+	gpio_asiu: gpio at 180a5000 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x180a5000 0x668>;
+		ngpios = <122>;
+		linux,gpio-base = <24>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpio_crmu: gpio at 03024800 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x03024800 0x50>;
+		ngpios = <6>;
+		linux,gpio-base = <146>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		no-drv-strength;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
