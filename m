From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:09 +0100
Subject: [PATCH 1/5] ARM: dts: zynq: Split out common Parallella bits
In-Reply-To: <1423702513-4032-1-git-send-email-afaerber@suse.de>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
Message-ID: <1423702513-4032-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares for the USB-less Microserver edition as well as
headless vs. HDMI bitstreams.

Cc: Ola Jeppsson <ola@adapteva.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/zynq-parallella.dts              | 80 +---------------------
 .../{zynq-parallella.dts => zynq-parallella1.dtsi} |  3 +-
 2 files changed, 3 insertions(+), 80 deletions(-)
 copy arch/arm/boot/dts/{zynq-parallella.dts => zynq-parallella1.dtsi} (97%)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 0ebd2107022b..99ee6551ae8d 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -1,11 +1,6 @@
 /*
  * Copyright (c) 2014 SUSE LINUX Products GmbH
- *
- * Derived from zynq-zed.dts:
- *
- *  Copyright (C) 2011 Xilinx
- *  Copyright (C) 2012 National Instruments Corp.
- *  Copyright (C) 2013 Xilinx
+ * Copyright (c) 2015 SUSE Linux GmbH
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -17,79 +12,8 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-parallella1.dtsi"
 
 / {
 	model = "Adapteva Parallella Board";
-	compatible = "adapteva,parallella", "xlnx,zynq-7000";
-
-	aliases {
-		ethernet0 = &gem0;
-		serial0 = &uart1;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x40000000>;
-	};
-
-	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
-		linux,stdout-path = "/amba/serial at e0001000";
-	};
-};
-
-&clkc {
-	fclk-enable = <0xf>;
-	ps-clk-frequency = <33333333>;
-};
-
-&gem0 {
-	status = "okay";
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethernet_phy>;
-
-	ethernet_phy: ethernet-phy at 0 {
-		/* Marvell 88E1318 */
-		compatible = "ethernet-phy-id0141.0e90",
-		             "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
-		marvell,reg-init = <0x3 0x10 0xff00 0x1e>,
-		                   <0x3 0x11 0xfff0 0xa>;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	isl9305: isl9305 at 68 {
-		compatible = "isil,isl9305";
-		reg = <0x68>;
-
-		regulators {
-			dcd1 {
-				regulator-name = "VDD_DSP";
-				regulator-always-on;
-			};
-			dcd2 {
-				regulator-name = "1P35V";
-				regulator-always-on;
-			};
-			ldo1 {
-				regulator-name = "VDD_ADJ";
-			};
-			ldo2 {
-				regulator-name = "VDD_GPIO";
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&sdhci1 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella1.dtsi
similarity index 97%
copy from arch/arm/boot/dts/zynq-parallella.dts
copy to arch/arm/boot/dts/zynq-parallella1.dtsi
index 0ebd2107022b..7c1206f928bc 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella1.dtsi
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2014 SUSE LINUX Products GmbH
+ * Copyright (c) 2015 SUSE Linux GmbH
  *
  * Derived from zynq-zed.dts:
  *
@@ -16,11 +17,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/dts-v1/;
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Adapteva Parallella Board";
 	compatible = "adapteva,parallella", "xlnx,zynq-7000";
 
 	aliases {
-- 
2.2.2
