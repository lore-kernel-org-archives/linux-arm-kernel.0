From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:54:44 +0100
Subject: [PATCH 1/8] nvmem: Add DT binding documentation for Vybrid OCOTP
 driver
In-Reply-To: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443617684-26311-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sanchayan Maity <maitysanchayan@gmail.com>

Add the devicetree bindings for the Freescale Vybrid On-Chip
OTP driver.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/vf610-ocotp.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
new file mode 100644
index 0000000..56ed481
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
@@ -0,0 +1,19 @@
+On-Chip OTP Memory for Freescale Vybrid
+
+Required Properties:
+  compatible:
+  - "fsl,vf610-ocotp" for VF5xx/VF6xx
+  #address-cells : Should be 1
+  #size-cells : Should be 1
+  reg : Address and length of OTP controller and fuse map registers
+  clocks : ipg clock we associate with the OCOTP peripheral
+
+Example for Vybrid VF5xx/VF6xx:
+
+	ocotp: ocotp at 400a5000 {
+		compatible = "fsl,vf610-ocotp";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x400a5000 0xCF0>;
+		clocks = <&clks VF610_CLK_OCOTP>;
+	};
-- 
1.9.1
