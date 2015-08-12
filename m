From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 12 Aug 2015 22:21:54 +0000
Subject: [PATCH V6 1/3] DT: nvmem: add binding for mxs-ocotp
In-Reply-To: <1439418116-1833-1-git-send-email-stefan.wahren@i2se.com>
References: <1439418116-1833-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1439418116-1833-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the devicetree bindings for the Freescale MXS On Chip
OTP driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
new file mode 100644
index 0000000..daebce9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
@@ -0,0 +1,25 @@
+On-Chip OTP Memory for Freescale i.MX23/i.MX28
+
+Required properties :
+- compatible :
+  - "fsl,imx23-ocotp" for i.MX23
+  - "fsl,imx28-ocotp" for i.MX28
+- #address-cells : Should be 1
+- #size-cells : Should be 1
+- reg : Address and length of OTP controller registers
+- clocks : Should contain a reference to the hbus clock
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
+		status = "okay";
+	};
-- 
1.7.9.5
