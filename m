From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 11:29:33 +0800
Subject: [PATCH] ARM: dts: imx: replace legacy wakeup property with
 'wakeup-source'
Message-ID: <1453951773-22507-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux,wakeup" and "enable-sdio-wakeup" boolean
property to enable the wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
This is a resend of Sudeep's patch with following updates:

 - Revise patch subject and commit log a bit to cover enable-sdio-wakeup
 - Rebase it onto v4.5-rc1 and have the following two instances updated
   > imx6qdl-nitrogen6_max.dtsi:141: gpio-key,wakeup;
   > imx7d-sbc-imx7.dts:25: enable-sdio-wakeup;

 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts                   | 2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi           | 4 ++--
 arch/arm/boot/dts/imx28-tx28.dts                       | 2 +-
 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts | 2 +-
 arch/arm/boot/dts/imx51-babbage.dts                    | 2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi      | 2 +-
 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 2 +-
 arch/arm/boot/dts/imx53-ard.dts                        | 6 +++---
 arch/arm/boot/dts/imx53-qsb-common.dtsi                | 4 ++--
 arch/arm/boot/dts/imx53-tx53-x03x.dts                  | 2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts                  | 4 ++--
 arch/arm/boot/dts/imx53-tx53.dtsi                      | 2 +-
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts                 | 2 +-
 arch/arm/boot/dts/imx6q-gk802.dts                      | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1110.dts                  | 2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi                 | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi              | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi                 | 6 +++---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                     | 6 +++---
 arch/arm/boot/dts/imx6sl-warp.dts                      | 2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts                 | 2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                      | 4 ++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dts                 | 4 ++--
 arch/arm/boot/dts/imx7d-sbc-imx7.dts                   | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                        | 2 +-
 28 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index ed1d0b4578ef..cda6907a27b9 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -30,7 +30,7 @@
 			label = "BP1";
 			gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 7ac4f1af16ac..1eaa131e2d18 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -225,7 +225,7 @@
 			label = "User button";
 			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
index 927b391d2058..88594747f454 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
@@ -36,7 +36,7 @@
 			label = "SW3";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
@@ -49,7 +49,7 @@
 			label = "SW4";
 			gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 4ea89344a5ff..546d55c60d6a 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -202,7 +202,7 @@
 			0x02020049 /* row 2, col 2, KEY_KP9 */
 		>;
 		gpio-activelow;
-		linux,wakeup;
+		wakeup-source;
 		debounce-delay-ms = <100>;
 		col-scan-delay-us = <5000>;
 		linux,no-autorepeat;
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index 75b036700d31..4727bbb804e1 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -30,7 +30,7 @@
 			label = "BP1";
 			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,input-type = <1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 649befeb2cf9..018d24eb9965 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -107,7 +107,7 @@
 			label = "Power Button";
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 321662f53e33..16fc69c69ab2 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -156,7 +156,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>;
 	cap-sdio-irq;
-	enable-sdio-wakeup;
+	wakeup-source;
 	keep-power-in-suspend;
 	max-frequency = <50000000>;
 	no-1-8-v;
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 34599c547459..d270df3e5891 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -41,7 +41,7 @@
 			label = "BP1";
 			gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
 			linux,code = <256>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,input-type = <1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 3bc18835fb4b..4486bc47d140 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -69,21 +69,21 @@
 			label = "Home";
 			gpios = <&gpio5 10 0>;
 			linux,code = <102>; /* KEY_HOME */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		back {
 			label = "Back";
 			gpios = <&gpio5 11 0>;
 			linux,code = <158>; /* KEY_BACK */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		program {
 			label = "Program";
 			gpios = <&gpio5 12 0>;
 			linux,code = <362>; /* KEY_PROGRAM */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		volume-up {
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 53fd75c8ffcf..368ccd0a053e 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -67,14 +67,14 @@
 			label = "Volume Up";
 			gpios = <&gpio2 14 0>;
 			linux,code = <115>; /* KEY_VOLUMEUP */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio2 15 0>;
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 13e842b0c785..0ecb43d88522 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -231,7 +231,7 @@
 		interrupts = <26 0>;
 		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <660>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 64804719f0f4..4520f1ec3d87 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -101,7 +101,7 @@
 		interrupt-parent = <&gpio3>;
 		interrupts = <23 0>;
 		wakeup-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
@@ -126,7 +126,7 @@
 		interrupt-parent = <&gpio3>;
 		interrupts = <22 0>;
 		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index d3e50b22064f..006289ae9f99 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -50,7 +50,7 @@
 			label = "Power Button";
 			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <116>; /* KEY_POWER */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
index c275eecc9472..d35a5cdc3229 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -77,7 +77,7 @@
 		interrupt-parent = <&gpio3>;
 		interrupts = <22 0>;
 		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index 00bd63e63d0c..b715deb4ea46 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -44,7 +44,7 @@
 			label = "recovery";
 			gpios = <&gpio3 16 1>;
 			linux,code = <0x198>; /* KEY_RESTART */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 88aa1e4c792d..2792da93db1f 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -77,7 +77,7 @@
 		interrupt-parent = <&gpio3>;
 		interrupts = <22 0>;
 		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index e26ebeb5b45c..a8f3500ee522 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -94,7 +94,7 @@
 			label = "User button";
 			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index a35d54fd9cd3..dc74aa395ff5 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -138,7 +138,7 @@
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index caeed56b74a3..c6c590d1e940 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -119,7 +119,7 @@
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 1a69a3420ac8..0f1aca450fe6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -105,7 +105,7 @@
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a6d445c17779..26b7a20a0abb 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -79,21 +79,21 @@
 		power {
 			label = "Power Button";
 			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,code = <KEY_POWER>;
 		};
 
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 13cb7ccfea44..14778298440c 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -52,7 +52,7 @@
 			label = "Power Button";
 			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
@@ -276,7 +276,7 @@
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
-		linux,wakeup;
+		wakeup-source;
 	};
 
 	touchscreen: tsc2007 at 48 {
@@ -288,7 +288,7 @@
 		interrupts = <26 0>;
 		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <660>;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 10c69963100f..058bcdceb81a 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -118,7 +118,7 @@
 	bus-width = <4>;
 	non-removable;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	mmc-pwrseq = <&usdhc3_pwrseq>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 115f3fd78971..96ea936eeeb0 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -52,7 +52,7 @@
 	cd-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	vmmc-supply = <&vcc_sd3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 94ac4005d9cd..e369f9e5dbc3 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -283,7 +283,7 @@
 	non-removable;
 	no-1-8-v;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	status = "okay";
 };
 
@@ -296,7 +296,7 @@
 	cd-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	vmmc-supply = <&vcc_sd3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 6aaa5ec3d846..e06fe978ae3b 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -131,7 +131,7 @@
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	vmmc-supply = <&reg_sd1_vmmc>;
 	status = "okay";
 };
@@ -141,7 +141,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	no-1-8-v;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
index d63c597c0783..f8a868552707 100644
--- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
@@ -22,7 +22,7 @@
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-	enable-sdio-wakeup;
+	wakeup-source;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index b2c453662905..b267f79e3059 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -296,7 +296,7 @@
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-	enable-sdio-wakeup;
+	wakeup-source;
 	keep-power-in-suspend;
 	status = "okay";
 };
-- 
1.9.1
