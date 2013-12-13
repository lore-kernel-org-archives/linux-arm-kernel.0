From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:33 +0900
Subject: [PATCH 07/69] ARM: shmobile: r8a7791 Koelsch DT reference DTS bits
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <1919a0a4b4a7e505fdeb99e9df449c9d90b0da0c.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DTS for the DT reference version of the Koelsch board support.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 32 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5839077..909d910 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -225,6 +225,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
new file mode 100644
index 0000000..b8a374a
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
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
-- 
1.8.4
