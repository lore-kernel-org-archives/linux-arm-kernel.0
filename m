From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:20:38 +0100
Subject: [PATCH 5/6] arm: mvebu: support for the Globalscale Mirabox board
In-Reply-To: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352740839-13586-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This platform, available from Globalscale has an Armada 370. For now,
only the serial port is supported. Support for network, USB and other
peripherals will be added as drivers for them become available for
Armada 370 in mainline.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is 3.8 material.

Changes from original version posted by Gregory:
 * Renamed .dts file to armada-370-mirabox.dts
 * Change compatible string to 'globalscale,mirabox'
 * Remove compatible string from armada-370-xp.c
 * Removed references to MBX0001
---
 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/armada-370-mirabox.dts |   37 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-mirabox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 718584d..32d1d40 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
+	armada-370-mirabox.dtb \
 	armada-xp-db.dtb \
 	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
new file mode 100644
index 0000000..9eef8dd
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -0,0 +1,37 @@
+/*
+ * Device Tree file for Globalscale Mirabox
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "Globalscale Mirabox";
+	compatible = "globalscale,mirabox", "marvell,armada370", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+		timer at d0020300 {
+			clock-frequency = <600000000>;
+			status = "okay";
+		};
+	};
+};
-- 
1.7.9.5
