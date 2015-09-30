From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:56:11 +0100
Subject: [PATCH 5/8] nvmem: add binding for mxs-ocotp
In-Reply-To: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443617771-26490-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Wahren <stefan.wahren@i2se.com>

This patch adds the devicetree bindings for the Freescale MXS On Chip
OTP driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        | 25 ++++++++++++++++++++++
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
1.9.1
