From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jan 2017 13:43:09 +0000
Subject: [PATCH 7/8] ARM: dts: STiH407-family: Use new Pinctrl groups
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Message-ID: <20170124134310.27512-8-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having just defined some new Pinctrl groups for when when HW flow-
control is {en,dis}abled, let's reference them for use within the
driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c8b2944..9789978 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -222,8 +222,9 @@
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_serial0>;
+			pinctrl-names = "default", "manual-rts";
+			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
+			pinctrl-1 = <&pinctrl_serial0>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 
 			status = "disabled";
-- 
2.10.2
