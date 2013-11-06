From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:31:07 +0900
Subject: [PATCH 01/03] ARM: shmobile: r7s72100 Genmai DT reference DTS bits
In-Reply-To: <20131106233032.8117.71968.sendpatchset@w520>
References: <20131106233032.8117.71968.sendpatchset@w520>
Message-ID: <20131106233107.8117.46385.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add the DT bits for r7s72100 Genmai DT reference support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile                      |    1 
 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   31 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

--- 0013/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-11-06 19:16:15.000000000 +0900
@@ -199,6 +199,7 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r7s72100-genmai-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-06 19:16:16.000000000 +0900
@@ -0,0 +1,31 @@
+/*
+ * Device Tree Source for the Genmai board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r7s72100.dtsi"
+
+/ {
+	model = "Genmai";
+	compatible = "renesas,genmai-reference", "renesas,r7s72100";
+
+	chosen {
+		bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x08000000 0x08000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
