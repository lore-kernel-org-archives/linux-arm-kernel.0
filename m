From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 22:12:11 -0300
Subject: [PATCH 3/4] ARM: dts: Add basic support for mx27_3ds board
In-Reply-To: <1334193132-18944-1-git-send-email-festevam@gmail.com>
References: <1334193132-18944-1-git-send-email-festevam@gmail.com>
Message-ID: <1334193132-18944-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a very basic dt support for mx27_3ds (also known as mx27pdk).

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-3ds.dts |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-3ds.dts

diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
new file mode 100644
index 0000000..d3f8296
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-3ds.dts
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2012 Sascha Hauer, Pengutronix
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
+/include/ "imx27.dtsi"
+
+/ {
+	model = "mx27_3ds";
+	compatible = "freescale,imx27-3ds", "fsl,imx27";
+
+	memory {
+		reg = <0x0 0x0>;
+	};
+
+	soc {
+		aipi at 10000000 { /* aipi */
+
+			wdog at 10002000 {
+				status = "okay";
+			};
+
+			uart at 1000a000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
+			fec at 1002b000 {
+				status = "okay";
+			};
+		};
+	};
+
+};
-- 
1.7.1
