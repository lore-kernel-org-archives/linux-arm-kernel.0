From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 12 Aug 2015 18:49:21 +0530
Subject: [PATCH v9 4/4] nvmem: Add DT binding documentation for Vybrid OCOTP
 driver
In-Reply-To: <cover.1439384645.git.maitysanchayan@gmail.com>
References: <cover.1439384645.git.maitysanchayan@gmail.com>
Message-ID: <24fcfdc695907103e8f4602b7dc6b8fa38e85ec1.1439384645.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree bindings for the Freescale Vybrid On-Chip
OTP driver.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/vf610-ocotp.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
new file mode 100644
index 0000000..b29f65f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
@@ -0,0 +1,21 @@
+On-Chip OTP Memory for Freescale Vybrid
+
+Required Properties:
+  compatible:
+  - "fsl,vf610-ocotp" for VF5xx/VF6xx
+  #address-cells : Should be 1
+  #size-cells : Should be 1
+  reg : Address and length of OTP controller and fuse map registers
+  clocks : ipg clock we associate with the OCOTP peripheral
+  clock-names : Must contain "ocotp" as matching entry
+
+Example for Vybrid VF5xx/VF6xx:
+
+	ocotp: ocotp at 400a5000 {
+		compatible = "fsl,vf610-ocotp";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x400a5000 0xCF0>;
+		clocks = <&clks VF610_CLK_OCOTP>;
+		clock-names = "ocotp";
+	};
-- 
2.5.0
