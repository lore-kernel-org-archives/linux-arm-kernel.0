From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 23 Feb 2018 18:16:37 +0800
Subject: [PATCH v1 17/19] arm: dts: mt7623: add MT7623N reference board with
 eMMC
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
Message-ID: <45572848513719fd4099c0f3564b06743b1be27b.1519378872.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add MT7623N reference board with eMMC. On the board, there is additional
external PHY which is ICPlus IP1001 transceiver available by port 5 on the
MDIO bus connectted with GMAC2.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38..5af6fce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1122,6 +1122,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
+	mt7623n-rfb-emmc.dtb \
 	mt7623n-rfb-nand.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
new file mode 100644
index 0000000..0db75bc
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include "mt7623n-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623N with eMMC reference board";
+	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+
+	chosen {
+		bootargs = "console=ttyS2,115200n8 earlyprintk";
+	};
+};
+
+&eth {
+	gmac1: mac at 1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+};
+
+&mdio {
+	phy5: ethernet-phy at 5 {
+		reg = <5>;
+		phy-mode = "rgmii-rxid";
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
-- 
2.7.4
