From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 May 2014 10:24:52 +0900
Subject: [PATCH 3/5] ARM: shmobile: Sync Genmai DTS with Genmai reference DTS
In-Reply-To: <cover.1400289483.git.horms+renesas@verge.net.au>
References: <cover.1400289483.git.horms+renesas@verge.net.au>
Message-ID: <2606f47be55fd4545ed9236467682c636fd23f9d.1400289483.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Copy the device nodes from Genmai reference into the Genmai device tree
file. This will allow us to use a single DTS file regardless of kernel
configuration. In case of legacy C board code the device nodes may or
may not be used, but in the multiplatform case all the DT device nodes
will be used.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index b1deaf7..56849b5 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree Source for the Genmai board
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-14 Renesas Solutions Corp.
+ * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -15,6 +16,10 @@
 	model = "Genmai";
 	compatible = "renesas,genmai", "renesas,r7s72100";
 
+	aliases {
+		serial2 = &scif2;
+	};
+
 	chosen {
 		bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -29,3 +34,26 @@
 		#size-cells = <1>;
 	};
 };
+
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom at 50 {
+		compatible = "renesas,24c128";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&scif2 {
+	status = "okay";
+};
-- 
1.8.4
