From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Mar 2018 14:58:20 +0100
Subject: [PATCH 3/3] ARM: ux500: Drop the U8540 device trees
In-Reply-To: <20180307135820.16221-1-linus.walleij@linaro.org>
References: <20180307135820.16221-1-linus.walleij@linaro.org>
Message-ID: <20180307135820.16221-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The U8540 was an evolved version of the U8500, but it was never
mass produced or put into products, only reference designs exist.
The upstream support was never completed and it is unlikely that
this will happen so drop the support for now to simplify
maintenance of the U8500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                 |   4 +-
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi | 196 -----------------------------
 arch/arm/boot/dts/ste-ccu8540.dts          |  94 --------------
 arch/arm/boot/dts/ste-ccu9540.dts          |  79 ------------
 4 files changed, 1 insertion(+), 372 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540.dts
 delete mode 100644 arch/arm/boot/dts/ste-ccu9540.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..6e09b474272b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1033,9 +1033,7 @@ dtb-$(CONFIG_ARCH_U8500) += \
 	ste-hrefprev60-stuib.dtb \
 	ste-hrefprev60-tvk.dtb \
 	ste-hrefv60plus-stuib.dtb \
-	ste-hrefv60plus-tvk.dtb \
-	ste-ccu8540.dtb \
-	ste-ccu9540.dtb
+	ste-hrefv60plus-tvk.dtb
 dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld4-ref.dtb \
 	uniphier-ld6b-ref.dtb \
diff --git a/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi b/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
deleted file mode 100644
index 52dba2e39c71..000000000000
--- a/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include "ste-nomadik-pinctrl.dtsi"
-
-/ {
-	soc {
-		pinctrl {
-			uart0 {
-				uart0_default_mux: uart0_mux {
-					default_mux {
-						function = "u0";
-						groups = "u0_a_1";
-					};
-				};
-
-				uart0_default_mode: uart0_default {
-					default_cfg1 {
-						pins = "GPIO0", "GPIO2";
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						pins = "GPIO1", "GPIO3";
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart0_sleep_mode: uart0_sleep {
-					sleep_cfg1 {
-						pins = "GPIO0", "GPIO2";
-						ste,config = <&slpm_in_pu>;
-					};
-
-					sleep_cfg2 {
-						pins = "GPIO1", "GPIO3";
-						ste,config = <&slpm_out_hi>;
-					};
-				};
-			};
-
-			uart2 {
-				uart2_default_mode: uart2_default {
-					default_mux {
-						function = "u2";
-						groups = "u2txrx_a_1";
-					};
-
-					default_cfg1 {
-						pins = "GPIO120";
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						pins = "GPIO121";
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart2_sleep_mode: uart2_sleep {
-					sleep_cfg1 {
-						pins = "GPIO120";
-						ste,config = <&slpm_in_pu>;
-					};
-
-					sleep_cfg2 {
-						pins = "GPIO121";
-						ste,config = <&slpm_out_hi>;
-					};
-				};
-			};
-
-			i2c0 {
-				i2c0_default_mux: i2c_mux {
-					default_mux {
-						function = "i2c0";
-						groups = "i2c0_a_1";
-					};
-				};
-
-				i2c0_default_mode: i2c_default {
-					default_cfg1 {
-						pins = "GPIO147", "GPIO148";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c0_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO147", "GPIO148";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c1 {
-				i2c1_default_mux: i2c_mux {
-					default_mux {
-						function = "i2c1";
-						groups = "i2c1_b_2";
-					};
-				};
-
-				i2c1_default_mode: i2c_default {
-					default_cfg1 {
-						pins = "GPIO16", "GPIO17";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c1_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO16", "GPIO17";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c2 {
-				i2c2_default_mux: i2c_mux {
-					default_mux {
-						function = "i2c2";
-						groups = "i2c2_b_2";
-					};
-				};
-
-				i2c2_default_mode: i2c_default {
-					default_cfg1 {
-						pins = "GPIO10", "GPIO11";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c2_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO11", "GPIO11";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c4 {
-				i2c4_default_mux: i2c_mux {
-					default_mux {
-						function = "i2c4";
-						groups = "i2c4_b_2";
-					};
-				};
-
-				i2c4_default_mode: i2c_default {
-					default_cfg1 {
-						pins = "GPIO122", "GPIO123";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c4_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO122", "GPIO123";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c5 {
-				i2c5_default_mux: i2c_mux {
-					default_mux {
-						function = "i2c5";
-						groups = "i2c5_c_2";
-					};
-				};
-
-				i2c5_default_mode: i2c_default {
-					default_cfg1 {
-						pins = "GPIO118", "GPIO119";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c5_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						pins = "GPIO118", "GPIO119";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
deleted file mode 100644
index 6eaaf638e52e..000000000000
--- a/arch/arm/boot/dts/ste-ccu8540.dts
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Copyright 2013 ST-Ericsson AB
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-#include "ste-dbx5x0.dtsi"
-#include "ste-ccu8540-pinctrl.dtsi"
-
-/ {
-	model = "ST-Ericsson U8540 platform with Device Tree";
-	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
-
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
-
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x20000000 0x1f000000>, <0xc0000000 0x3f000000>;
-	};
-
-	soc {
-		pinctrl {
-			compatible = "stericsson,db8540-pinctrl";
-		};
-
-		prcmu at 80157000 {
-			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x3000>;
-			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
-		};
-
-		uart at 80120000 {
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart0_default_mux>, <&uart0_default_mode>;
-			pinctrl-1 = <&uart0_sleep_mode>;
-			status = "okay";
-		};
-
-		uart at 80121000 {
-			status = "okay";
-		};
-
-		uart at 80007000 {
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&uart2_default_mode>;
-			pinctrl-1 = <&uart2_sleep_mode>;
-			status = "okay";
-		};
-
-		i2c0: i2c at 80004000 {
-			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c0_default_mux>, <&i2c0_default_mode>;
-			pinctrl-1 = <&i2c0_sleep_mode>;
-		};
-
-		i2c1: i2c at 80122000 {
-			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c1_default_mux>, <&i2c1_default_mode>;
-			pinctrl-1 = <&i2c1_sleep_mode>;
-		};
-
-		i2c2: i2c at 80128000 {
-			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c2_default_mux>, <&i2c2_default_mode>;
-			pinctrl-1 = <&i2c2_sleep_mode>;
-		};
-
-		i2c3: i2c at 80110000 {
-			status = "disabled";
-		};
-
-		i2c4: i2c at 8012a000 {
-			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c4_default_mux>, <&i2c4_default_mode>;
-			pinctrl-1 = <&i2c4_sleep_mode>;
-		};
-
-		i2c5: i2c at 80001000 {
-			pinctrl-names = "default","sleep";
-			pinctrl-0 = <&i2c5_default_mux>, <&i2c5_default_mode>;
-			pinctrl-1 = <&i2c5_sleep_mode>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ste-ccu9540.dts b/arch/arm/boot/dts/ste-ccu9540.dts
deleted file mode 100644
index b3b9bb8e1aa8..000000000000
--- a/arch/arm/boot/dts/ste-ccu9540.dts
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson AB
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-#include "ste-dbx5x0.dtsi"
-
-/ {
-	model = "ST-Ericsson CCU9540 platform with Device Tree";
-	compatible = "st-ericsson,ccu9540", "st-ericsson,u9540";
-
-	/* This stablilizes the serial port enumeration */
-	aliases {
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
-	};
-
-	memory {
-		reg = <0x00000000 0x20000000>;
-	};
-
-	soc {
-		uart at 80120000 {
-			status = "okay";
-		};
-
-		uart at 80121000 {
-			status = "okay";
-		};
-
-		uart at 80007000 {
-			status = "okay";
-		};
-
-		// External Micro SD slot
-		sdi0_per1 at 80126000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-			cap-sd-highspeed;
-			cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux3_reg>;
-
-			cd-gpios  = <&gpio7 6 GPIO_ACTIVE_HIGH>; // 230
-			cd-inverted;
-
-			status = "okay";
-		};
-
-
-		// WLAN SDIO channel
-		sdi1_per2 at 80118000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-
-			status = "okay";
-		};
-
-		// On-board eMMC
-		sdi4_per2 at 80114000 {
-			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <100000000>;
-			bus-width = <8>;
-			cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-
-			status = "okay";
-		};
-	};
-};
-- 
2.14.3
