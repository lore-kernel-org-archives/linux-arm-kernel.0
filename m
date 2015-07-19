From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 19 Jul 2015 22:04:57 +0000
Subject: [PATCH V4 RFC 1/3] DT: nvmem: add binding for mxs-ocotp
In-Reply-To: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
References: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1437343499-16422-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the devicetree bindings for the Freescale MXS On Chip
OTP driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
new file mode 100644
index 0000000..cd2a8cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
@@ -0,0 +1,24 @@
+On-Chip OTP Memory for Freescale i.MX23/i.MX28
+
+Required properties:
+- compatible:
+  - "fsl,imx23-ocotp" for i.MX23
+  - "fsl,imx28-ocotp" for i.MX28
+- #address-cells : Should be 1
+- #size-cells : Should be 1
+- reg : Address and length of OTP controller registers
+- clocks : Should contain a reference to the HBus clock
+
+= Data cells =
+Are child nodes of mxs-ocotp, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example for i.MX28:
+
+	ocotp: ocotp at 8002c000 {
+		compatible = "fsl,imx28-ocotp", "fsl,ocotp";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x8002c000 0x2000>;
+		clocks = <&clks 25>;
+	};
-- 
1.7.9.5
