From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:16 +0200
Subject: [PATCH 3/7] ARM: dts: at91: fix i2c-gpio node name
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c-gpio doesn't need a reg property. Change the node names to i2c-gpio-x
as used in other dts to remove the unit-address.

Solves:
Warning (unit_address_vs_reg): Node /i2c at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-foxg20.dts           | 2 +-
 arch/arm/boot/dts/at91-kizbox.dts           | 2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts        | 2 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts       | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi           | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9260ek.dts         | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9263ek.dts         | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           | 4 ++--
 arch/arm/boot/dts/at91sam9rlek.dts          | 4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi           | 6 +++---
 arch/arm/boot/dts/ethernut5.dts             | 2 +-
 arch/arm/boot/dts/evk-pro3.dts              | 2 +-
 arch/arm/boot/dts/mpa1600.dts               | 2 +-
 arch/arm/boot/dts/tny_a9263.dts             | 2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi     | 2 +-
 arch/arm/boot/dts/usb_a9263.dts             | 2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi     | 2 +-
 23 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index 07c9bacf1ae6..50d5e719b451 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -125,7 +125,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c0>;
 		i2c-gpio,delay-us = <5>;	/* ~85 kHz */
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 0e3f34e084b5..b4f147c193fd 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -96,7 +96,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 
 		rtc: pcf8563 at 51 {
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 5ad3d90f9d39..8f019184fccf 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -178,7 +178,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
index 814753ab26a0..171243ca4f2f 100644
--- a/arch/arm/boot/dts/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -99,7 +99,7 @@
 
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index f6cb7a80a2f5..4e913c2ccb79 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -948,7 +948,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 25 GPIO_ACTIVE_HIGH /* sda */
 			 &pioA 26 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 49a02f5a4476..a3e363d79122 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -1013,7 +1013,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 23 GPIO_ACTIVE_HIGH /* sda */
 			 &pioA 24 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index 0a29bd0dd9bf..2c87f58448e7 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -185,7 +185,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 
 		24c512 at 50 {
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 5e09de4eb9cd..32752d7883f1 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -860,7 +860,7 @@
 		};
 	};
 
-	i2c@0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c_bitbang>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 93446420af25..aeb1a36373f4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -1019,7 +1019,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioB 4 GPIO_ACTIVE_HIGH /* sda */
 			 &pioB 5 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 59df9d73d276..127cc42e9e29 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -215,7 +215,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 
 		24c512 at 50 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 1395b30adad6..27847a47c108 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -176,7 +176,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 
 		24c512 at 50 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c8789a8a0a1d..b3501ae2a3bd 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1316,7 +1316,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 20 GPIO_ACTIVE_HIGH /* sda */
 			 &pioA 21 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 95569a87b6c9..3b3eb3edcb47 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -1030,7 +1030,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 30 GPIO_ACTIVE_HIGH /* sda */
 			 &pioA 31 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index cdaae8eb038c..70adf940d98c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -1089,7 +1089,7 @@
 		};
 	};
 
-	i2c@0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 23 GPIO_ACTIVE_HIGH>, /* sda */
 			<&pioA 24 GPIO_ACTIVE_HIGH>; /* scl */
@@ -1103,7 +1103,7 @@
 		status = "disabled";
 	};
 
-	i2c at 1 {
+	i2c-gpio-1 {
 		compatible = "i2c-gpio";
 		gpios = <&pioD 10 GPIO_ACTIVE_HIGH>, /* sda */
 			<&pioD 11 GPIO_ACTIVE_HIGH>; /* scl */
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index f10566f759cd..2e567d90fba8 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -227,11 +227,11 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 
-	i2c at 1 {
+	i2c-gpio-1 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index f14ed909236c..ed4e4bd8a8f1 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1238,7 +1238,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 30 GPIO_ACTIVE_HIGH /* sda */
 			 &pioA 31 GPIO_ACTIVE_HIGH /* scl */
@@ -1253,7 +1253,7 @@
 		status = "disabled";
 	};
 
-	i2c at 1 {
+	i2c-gpio-1 {
 		compatible = "i2c-gpio";
 		gpios = <&pioC 0 GPIO_ACTIVE_HIGH /* sda */
 			 &pioC 1 GPIO_ACTIVE_HIGH /* scl */
@@ -1268,7 +1268,7 @@
 		status = "disabled";
 	};
 
-	i2c at 2 {
+	i2c-gpio-2 {
 		compatible = "i2c-gpio";
 		gpios = <&pioB 4 GPIO_ACTIVE_HIGH /* sda */
 			 &pioB 5 GPIO_ACTIVE_HIGH /* scl */
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 298ee2fd2b51..4687229a3ab9 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -83,7 +83,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 
 		pcf8563 at 50 {
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index 312d3e80b538..20a4481b6e12 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -52,7 +52,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index 30e66e57870c..116ce78bea4f 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -52,7 +52,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 2f39f85158f7..9161cd9889b4 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -90,7 +90,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 0f3a02b336a2..7514b347cdd2 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -110,7 +110,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 94c615072f3b..bfc48a272417 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -138,7 +138,7 @@
 		};
 	};
 
-	i2c@0 {
+	i2c-gpio-0 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/usb_a9g20_common.dtsi
index 6156ee878345..088c2c3685ab 100644
--- a/arch/arm/boot/dts/usb_a9g20_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
@@ -19,7 +19,7 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
-	i2c at 0 {
+	i2c-gpio-0 {
 		rv3029c2 at 56 {
 			compatible = "rv3029c2";
 			reg = <0x56>;
-- 
2.8.1
