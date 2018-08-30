From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Aug 2018 19:15:34 +0200
Subject: [PATCH 1/6] dt-bindings: crypto: Add Freescale Vybrid CRC
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Message-ID: <20180830171539.20008-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for Freescale/NXP Vybrid CRC HW accelerator.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/crypto/fsl-vf610-crc.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt b/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
new file mode 100644
index 000000000000..cdd7e26baeac
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
@@ -0,0 +1,16 @@
+Freescale/NXP Vybrid VF500/VF610 CRC HW accelerator
+
+Required properties:
+- compatible : Should be "fsl,vf610-crc"
+- reg : Should contain register location and length.
+- clocks : Should contain the clock driving the CRC block.
+- clock-names : Should be set to "crc".
+
+Example:
+
+crc at 40033000 {
+	compatible = "fsl,vf610-crc";
+	reg = <0x40033000 0x10>;
+	clocks = <&clks VF610_CLK_CRC>;
+	clock-names = "crc";
+};
-- 
2.14.1
