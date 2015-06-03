From: tony@atomide.com (Tony Lindgren)
Date: Wed,  3 Jun 2015 09:23:19 -0700
Subject: [PATCH 10/12] ARM: dts: Add minimal dts support for dm8148-evm
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Message-ID: <1433348601-8966-11-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal dts support for dm8148-evm.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile       |  1 +
 arch/arm/boot/dts/dm8148-evm.dts | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/dm8148-evm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 992736b..9884c23 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -404,6 +404,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
 	omap3-thunder.dtb \
 	omap3-zoom3.dtb
 dtb-$(CONFIG_SOC_TI81XX) += \
+	dm8148-evm.dtb \
 	dm8168-evm.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-base0033.dtb \
diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
new file mode 100644
index 0000000..92bacd3
--- /dev/null
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -0,0 +1,28 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dm814x.dtsi"
+
+/ {
+	model = "DM8148 EVM";
+	compatible = "ti,dm8148-evm", "ti,dm8148";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;	/* 1 GB */
+	};
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "mii";
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "mii";
+};
-- 
2.1.4
