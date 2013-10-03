From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  3 Oct 2013 23:21:39 +0200
Subject: [PATCH v2 3/5] ARM: socfpga: dts: Add support for terasic SoCkit
In-Reply-To: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1380835301-26512-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic support for the terasic SoCkit board.
The board includes an Altera Cyclone 5 SoC.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
---
Changes in v2:
	- Fix baudrate of serial console

 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 37 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fcace86..7ce51f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -217,6 +217,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5_socdk.dtb \
+	socfpga_cyclone5_sockit.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
new file mode 100644
index 0000000..50b99a2
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (C) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/include/ "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Terasic SoCkit";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+};
+
+&gmac1 {
+	status = "okay";
+};
-- 
1.8.4.rc3
