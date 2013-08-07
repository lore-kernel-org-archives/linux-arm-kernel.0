From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:33 +0900
Subject: [GIT PULL 09/19] ARM: shmobile: marzen: Add  r8a7779-marzen.dtb
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <d6b51d6b6a33974dfa7b091f61e7a2bedd62f298.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in preparation for converting the marzen board to
use DT_MACHINE_START.

Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/r8a7779-marzen.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e01d63f..07204ca 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -188,6 +188,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
+	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
new file mode 100644
index 0000000..f3f7f79
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for the Marzen board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7779.dtsi"
+
+/ {
+	model = "marzen";
+	compatible = "renesas,marzen", "renesas,r8a7779";
+
+	chosen {
+		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+};
-- 
1.8.3.2
