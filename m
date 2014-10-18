From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Oct 2014 10:32:50 +0000
Subject: [PATCH RFC V3 1/3] mxs: add binding for fsl ocotp
In-Reply-To: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1413628372-2809-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Device tree bindings for the Freescale MXS On Chip
OTP driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/misc/fsl,octop.txt         |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,octop.txt

diff --git a/Documentation/devicetree/bindings/misc/fsl,octop.txt b/Documentation/devicetree/bindings/misc/fsl,octop.txt
new file mode 100644
index 0000000..db1c510
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/fsl,octop.txt
@@ -0,0 +1,14 @@
+On-Chip OTP Memory for Freescale MX23/MX28
+
+Required properties:
+- compatible:
+  - "fsl,imx23-ocotp" for MX23
+  - "fsl,imx23-ocotp" for MX28
+- reg : Address and length of OTP controller registers
+
+Example:
+
+	ocotp: ocotp at 8002c000 {
+		compatible = "fsl,imx28-ocotp", "fsl,ocotp";
+		reg = <0x8002c000 0x2000>;
+	};
-- 
1.7.9.5
