From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 15:30:09 +0900
Subject: [PATCH 01/02] ARM: shmobile: r8a7791 Koelsch DT reference DTS bits
In-Reply-To: <20131008063000.24789.7845.sendpatchset@w520>
References: <20131008063000.24789.7845.sendpatchset@w520>
Message-ID: <20131008063009.24789.91522.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DTS for the DT reference version of the Koelsch board support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile                      |    1 
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts |   32 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-10-08 15:08:35.000000000 +0900
@@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-10-08 15:08:36.000000000 +0900
@@ -0,0 +1,32 @@
+/*
+ * Device Tree Source for the Koelsch board
+ *
+ * Copyright (C) 2013 Renesas Electronics Corporation
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7791.dtsi"
+
+/ {
+	model = "Koelsch";
+	compatible = "renesas,koelsch-reference", "renesas,r8a7791";
+
+	chosen {
+		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
