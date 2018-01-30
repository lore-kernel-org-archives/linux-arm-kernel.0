From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Tue, 30 Jan 2018 23:03:57 +0530
Subject: [PATCH 2/2] dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage
 example
In-Reply-To: <1517333637-17331-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1517333637-17331-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1517333637-17331-3-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added usage example by adding support for spi-rx-bus-width
and spi-tx-bus-width binding.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
index 63d4d626..811da0e 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -39,3 +39,33 @@ qspi0: quadspi at 40044000 {
 		....
 	};
 };
+
+qspi1: quadspi at 20c0000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x0 0x20c0000 0x0 0x10000>,
+		<0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "QuadSPI", "QuadSPI-memory";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "qspi_en", "qspi";
+	status = "okay";
+
+	qflash0: s25fs512s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+
+	qflash1: s25fs512s at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
-- 
1.9.1
