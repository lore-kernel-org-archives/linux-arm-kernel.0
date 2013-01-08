From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  8 Jan 2013 19:52:53 +0100
Subject: [PATCH] ARM: sunxi: Add device tree for Miniand Hackberry
Message-ID: <1357671173-3748-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                |    1 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts |   30 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-hackberry.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..b5dd258 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear320-hmi.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
+	sun4i-a10-hackberry.dtb \
 	sun5i-a13-olinuxino.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
new file mode 100644
index 0000000..f84549a
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun4i-a10.dtsi"
+
+/ {
+	model = "Miniand Hackberry";
+	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc {
+		uart0: uart at 01c28000 {
+			status = "okay";
+		};
+	};
+};
-- 
1.7.10.4
