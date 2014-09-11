From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:16 +0900
Subject: [PATCH 3/3] ARM: shmobile: Initial Alt board device tree
In-Reply-To: <cover.1410396013.git.horms+renesas@verge.net.au>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
Message-ID: <a742795be9ceae2853ca71f216193f29da151da8.1410396013.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: reduced to minimum, added cmt, enabled scif2, split off from SoC]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile        |  3 ++-
 arch/arm/boot/dts/r8a7794-alt.dts | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..81c1df9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -375,7 +375,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
-	r8a7779-marzen.dtb
+	r8a7779-marzen.dtb \
+	r8a7794-alt.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
new file mode 100644
index 0000000..79d06ef
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -0,0 +1,47 @@
+/*
+ * Device Tree Source for the Alt board
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7794.dtsi"
+
+/ {
+	model = "Alt";
+	compatible = "renesas,alt", "renesas,r8a7794";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&cmt0 {
+	status = "ok";
+};
+
+&scif2 {
+	status = "ok";
+};
-- 
2.0.1
