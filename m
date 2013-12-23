From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:07 +0900
Subject: [PATCH 11/26] ARM: shmobile: r7s72100 Genmai DT reference DTS bits
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <495e06d1daff7f59b511c27c95d2601c1d9dad49.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add the DT bits for r7s72100 Genmai DT reference support.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 31 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8254bfc..b17de79 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -218,6 +218,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r7s72100-genmai-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
new file mode 100644
index 0000000..da19c70
--- /dev/null
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
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
-- 
1.8.4
