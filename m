From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 11:10:37 -0800
Subject: [PATCH v3 2/8] ARM: dts: Specify clocks for UARTs on bcm11351
In-Reply-To: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
References: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384456243-27053-3-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frequency property in "snps,dw-apb-uart" entries are no longer
required if the rate of the external clock can be determined using the
clk api (see e302cd9 serial: 8250_dw: add support for clk api).

This patch replaces the frequency property in the UART nodes of
bcm11351.dtsi with references to the relevant clocks following the
common clock binding.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index eca6fbc..9b99c52 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -43,7 +43,7 @@
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		status = "disabled";
 		reg = <0x3e000000 0x1000>;
-		clock-frequency = <13000000>;
+		clocks = <&uartb_clk>;
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -53,7 +53,7 @@
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		status = "disabled";
 		reg = <0x3e001000 0x1000>;
-		clock-frequency = <13000000>;
+		clocks = <&uartb2_clk>;
 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -63,7 +63,7 @@
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		status = "disabled";
 		reg = <0x3e002000 0x1000>;
-		clock-frequency = <13000000>;
+		clocks = <&uartb3_clk>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -73,7 +73,7 @@
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		status = "disabled";
 		reg = <0x3e003000 0x1000>;
-		clock-frequency = <13000000>;
+		clocks = <&uartb4_clk>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
-- 
1.8.0.1
