From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  5 Nov 2018 13:42:25 +0000
Subject: [PATCH v2] ARM: dts: replace gpio-key,
 wakeup with wakeup-source property
Message-ID: <20181105134225.24146-1-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the legacy "gpio-key,wakeup" and "enable-sdio-wakeup" boolean
properties are already replaced with "wakeup-source". However few
occurrences of old property has popped up again, probably from the
remnants in downstream trees. Almost all of those were remove couple
of years back.

Replace those legacy properties with the unified "wakeup-source"
property.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
 arch/arm/boot/dts/at91-wb45n.dts            | 2 +-
 arch/arm/boot/dts/at91-wb50n.dts            | 4 ++--
 arch/arm/boot/dts/imx6q-pistachio.dts       | 2 +-
 arch/arm/boot/dts/imx6sll-evk.dts           | 2 +-
 arch/arm/boot/dts/zynq-zturn.dts            | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

Hi ARM SoC Team,

Though it's more a cleanup, I prefer if this can be pushed as fix
to avoid more duplication in downstream as well as having to split into
3 different patches.

--
Regards,
Sudeep

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 911d2c7c1500..5664b6728a4c 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -22,7 +22,7 @@
 		wakeup {
 			label = "Wakeup";
 			linux,code = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 			gpios = <&pioB 27 GPIO_ACTIVE_LOW>;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
index 5b9512a6c89c..54d130c92185 100644
--- a/arch/arm/boot/dts/at91-wb45n.dts
+++ b/arch/arm/boot/dts/at91-wb45n.dts
@@ -22,7 +22,7 @@
 			label = "IRQBTN";
 			linux,code = <99>;
 			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
index 8cecc7051a86..a5e45bb95c04 100644
--- a/arch/arm/boot/dts/at91-wb50n.dts
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -23,7 +23,7 @@
 			label = "BTNESC";
 			linux,code = <1>; /* ESC button */
 			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 		};

 		irqbtn at 31 {
@@ -31,7 +31,7 @@
 			label = "IRQBTN";
 			linux,code = <99>; /* SysReq button */
 			gpios = <&pioE 31 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup = <1>;
+			wakeup-source;
 		};
 	};

diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31e83cd07a3..8f4b60dd819c 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -102,7 +102,7 @@
 		power {
 			label = "Power Button";
 			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,code = <KEY_POWER>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index c8e115564ba2..30b5d63ed319 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -296,7 +296,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	keep-power-in-suspend;
-	enable-sdio-wakeup;
+	wakeup-source;
 	vmmc-supply = <&reg_sd3_vmmc>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
index b38704657960..5ec616ebca08 100644
--- a/arch/arm/boot/dts/zynq-zturn.dts
+++ b/arch/arm/boot/dts/zynq-zturn.dts
@@ -54,7 +54,7 @@
 			label = "K1";
 			gpios = <&gpio0 0x32 0x1>;
 			linux,code = <0x66>;
-			gpio-key,wakeup;
+			wakeup-source;
 			autorepeat;
 		};
 	};
--
2.17.1
