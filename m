From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 26 Feb 2018 12:18:20 +0000
Subject: [PATCH 2/2] arm: rzn1: Add basic support for RZN1D-DB Board
In-Reply-To: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1519647518-15579-3-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only enables the uart0 for now, and also relies on the bootloader
for setting up the clocks and pinctrl.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt |  2 ++
 arch/arm/boot/dts/rzn1d400-db.dts                  | 25 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/rzn1d400-db.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 153f69bb..498871b 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -105,6 +105,8 @@ Boards:
     compatible = "renesas,porter", "renesas,r8a7791"
   - RSKRZA1 (YR0K77210C000BE)
     compatible = "renesas,rskrza1", "renesas,r7s72100"
+  - RZN1D-DB (RZ/N1D Demo Board)
+    compatible = "renesas,rzn1d-db", "renesas,r9a06g032"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
diff --git a/arch/arm/boot/dts/rzn1d400-db.dts b/arch/arm/boot/dts/rzn1d400-db.dts
new file mode 100644
index 0000000..1b686f0
--- /dev/null
+++ b/arch/arm/boot/dts/rzn1d400-db.dts
@@ -0,0 +1,25 @@
+/*
+ * Device Tree Source for the RZN1D-DB Board
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+/dts-v1/;
+
+#include "rzn1.dtsi"
+
+/ {
+	model = "RZN1D-DB Board";
+	compatible = "renesas,rzn1d-db", "renesas,r9a06g032";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+		linux,stdout-path = &uart0;
+	};
+};
+&uart0 {
+	status = "okay";
+};
-- 
2.7.4
