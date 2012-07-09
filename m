From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Mon,  9 Jul 2012 21:39:13 +0200
Subject: [PATCH 2/2] arm/dts: Add support for i.MX31 bug 1.x board from
 buglabs.
In-Reply-To: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
References: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <1341862753-14848-3-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the main UART and the memory node information are added.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 arch/arm/boot/dts/imx31-bug.dts |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx31-bug.dts

diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
new file mode 100644
index 0000000..24731cb
--- /dev/null
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2012 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
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
+/include/ "imx31.dtsi"
+
+/ {
+	model = "Buglabs i.MX31 Bug 1.x";
+	compatible = "fsl,imx31-bug", "fsl,imx31";
+
+	memory {
+		reg = <0x80000000 0x8000000>; /* 128M */
+	};
+
+	soc {
+		aips at 43f00000 { /* AIPS1 */
+			uart5: serial at 43fb4000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.7.4.1
