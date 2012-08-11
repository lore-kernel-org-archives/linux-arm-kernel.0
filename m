From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Aug 2012 14:56:45 +0200
Subject: [PATCH 07/11] ARM: mvebu: Add pinctrl support to Armada XP SoCs
In-Reply-To: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1344689809-6223-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commits adds the necessary device tree information to define the
compatible property for the pinctrl driver instance of Armada XP SoCs.

Until now, the device tree representation considered the Armada XP as
a single SoC. But in fact, there are three different SoCs in the
Armada XP families, with different number of CPU cores, different
number of Ethernet interfaces... and different number of muxable pins
or functions. We therefore introduce three armada-xp-mv78xx0.dtsi for
the three SoCs of the Armada XP family. The current armada-xp-db.dts
evaluation board uses the MV78460 variant of the SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   27 +++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78230.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78260.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78460.dtsi

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
new file mode 100644
index 0000000..69ad287
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Include file for Marvell Armada XP family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada XP MV78230 SoC that are not
+ * common to all Armada XP SoCs.
+ */
+
+/include/ "armada-xp.dtsi"
+
+/ {
+	model = "Marvell Armada XP family SoC";
+	compatible = "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	soc {
+		pinctrl at d0018000 {
+			compatible = "marvell,mv78230-pinctrl";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
new file mode 100644
index 0000000..0f38fa9
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Include file for Marvell Armada XP family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada XP MV78260 SoC that are not
+ * common to all Armada XP SoCs.
+ */
+
+/include/ "armada-xp.dtsi"
+
+/ {
+	model = "Marvell Armada XP family SoC";
+	compatible = "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	soc {
+		pinctrl at d0018000 {
+			compatible = "marvell,mv78260-pinctrl";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
new file mode 100644
index 0000000..9e61836
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Include file for Marvell Armada XP family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada XP MV78460 SoC that are not
+ * common to all Armada XP SoCs.
+ */
+
+/include/ "armada-xp.dtsi"
+
+/ {
+	model = "Marvell Armada XP family SoC";
+	compatible = "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	soc {
+		pinctrl at d0018000 {
+			compatible = "marvell,mv78460-pinctrl";
+		};
+	};
+ };
-- 
1.7.10.4
