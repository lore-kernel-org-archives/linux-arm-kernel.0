From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 21:24:21 -0700
Subject: [PATCH 1/4] ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Message-ID: <20180628042424.12664-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZII's RDU1s come with up to 3 EEPROMs attached to RAVE SP. Add
corresponding nodes to make them availible.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index ad2445dfa91d..c6da263cf210 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -578,6 +578,8 @@
 	rave-sp {
 		compatible = "zii,rave-sp-rdu1";
 		current-speed = <38400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
 		watchdog {
 			compatible = "zii,rave-sp-watchdog";
@@ -590,6 +592,33 @@
 		pwrbutton {
 			compatible = "zii,rave-sp-pwrbutton";
 		};
+
+		eeprom at a3 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa3 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "dds-eeprom";
+		};
+
+		eeprom at a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};
+
+		eeprom at ae {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xae 0x200>;
+			zii,eeprom-name = "switch-eeprom";
+			/*
+			 * Not all RDU1s have this functionality, so we
+			 * rely on the bootloader to enable this
+			 */
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1
