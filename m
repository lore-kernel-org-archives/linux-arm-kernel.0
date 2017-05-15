From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 17:32:18 +0530
Subject: [PATCH v2 08/11] arm64: dts: Add GPIO DT nodes for Stingray SOC
In-Reply-To: <1494849741-21294-1-git-send-email-anup.patel@broadcom.com>
References: <1494849741-21294-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494849741-21294-9-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

The GPIOs on Stingray SOC are based on iProc GPIOs hence
using this we add GPIO DT nodes for Stingray SOC.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index c3a8cee..2b24d07 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -256,6 +256,14 @@
 		ranges = <0x0 0x0 0x66400000 0x100000>;
 
 		#include "stingray-clock.dtsi"
+
+		gpio_crmu: gpio at 66424800 {
+			compatible = "brcm,iproc-gpio";
+			reg = <0x00024800 0x4c>;
+			ngpios = <6>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 	};
 
 	hsls {
@@ -266,6 +274,32 @@
 
 		#include "stingray-pinctrl.dtsi"
 
+		gpio_hsls: gpio at 689d0000 {
+			compatible = "brcm,iproc-gpio";
+			reg = <0x000d0000 0x864>;
+			ngpios = <151>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&pinmux 0 0 16>,
+					<&pinmux 16 71 2>,
+					<&pinmux 18 131 8>,
+					<&pinmux 26 83 6>,
+					<&pinmux 32 123 4>,
+					<&pinmux 36 43 24>,
+					<&pinmux 60 89 2>,
+					<&pinmux 62 73 4>,
+					<&pinmux 66 95 28>,
+					<&pinmux 94 127 4>,
+					<&pinmux 98 139 10>,
+					<&pinmux 108 16 27>,
+					<&pinmux 135 77 6>,
+					<&pinmux 141 67 4>,
+					<&pinmux 145 149 6>,
+					<&pinmux 151 91 4>;
+		};
+
 		uart0: uart at 68a00000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
-- 
2.7.4
