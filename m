From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 16 May 2017 17:00:54 +0530
Subject: [PATCH v3 09/11] arm64: dts: Add I2C DT nodes for Stingray SoC
In-Reply-To: <1494934256-1350-1-git-send-email-anup.patel@broadcom.com>
References: <1494934256-1350-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494934256-1350-10-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oza Pawandeep <oza.oza@broadcom.com>

This patch adds I2C DT nodes on Stingray SoC.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 22 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index aad45a2..ff59a26 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -54,6 +54,28 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+
+	pca9505: pca9505 at 20 {
+		compatible = "nxp,pca9505";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x20>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	pcf8574: pcf8574 at 20 {
+		compatible = "nxp,pcf8574a";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x27>;
+	};
+};
+
 &nand {
 	status = "ok";
 	nandcs at 0 {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 059086f..8a077ff 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -269,6 +269,16 @@
 
 		#include "stingray-pinctrl.dtsi"
 
+		i2c0: i2c at 689b0000 {
+			compatible = "brcm,iproc-i2c";
+			reg = <0x000b0000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
 		gpio_hsls: gpio at 689d0000 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x000d0000 0x864>;
@@ -295,6 +305,16 @@
 					<&pinmux 151 91 4>;
 		};
 
+		i2c1: i2c at 689e0000 {
+			compatible = "brcm,iproc-i2c";
+			reg = <0x000e0000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 178 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
 		uart0: uart at 68a00000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
-- 
2.7.4
