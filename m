From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 13:27:07 +0900
Subject: [PATCH/RFC] ARM: shmobile: dts: Add common file for MSIOF1
Message-ID: <1416544027-5680-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

The R-Car Gen 2 SoCs have MSIOF1 interfaces however they
are not exposed on any boards currently supported in mainline.

The purpose of r8a77xx-msiof1.dtsi is to be included
in a dts file if MSIOF1 is exposed by some means.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[horms: Reworked into a separate dtsi file]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77xx-msiof1.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77xx-msiof1.dtsi

diff --git a/arch/arm/boot/dts/r8a77xx-msiof1.dtsi b/arch/arm/boot/dts/r8a77xx-msiof1.dtsi
new file mode 100644
index 0000000..04f91b8
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77xx-msiof1.dtsi
@@ -0,0 +1,24 @@
+/*
+ * Common file enabling MMSIOF1 on Renesas R-Car boards
+ *
+ * Copyright (C) 2014 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+&pfc {
+	msiof1_pins: spi2 {
+		renesas,groups = "msiof1_clk_c", "msiof1_sync_c", "msiof1_rx_c",
+				 "msiof1_tx_c";
+		renesas,function = "msiof1";
+	};
+};
+
+&msiof1 {
+	pinctrl-0 = <&msiof1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.1.1
