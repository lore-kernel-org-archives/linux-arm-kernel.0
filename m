From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Nov 2018 09:06:41 +0530
Subject: [PATCH v2 04/15] dt-bindings: interrupt-controller: Document
 RDA8810PL intc
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181121033652.12247-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document interrupt controller in RDA Micro RDA8810PL SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../interrupt-controller/rda,8810pl-intc.txt  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
new file mode 100644
index 000000000000..e0062aebf025
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
@@ -0,0 +1,61 @@
+RDA Micro RDA8810PL Interrupt Controller
+
+The interrupt controller in RDA8810PL SoC is a custom interrupt controller
+which supports up to 32 interrupts.
+
+Required properties:
+
+- compatible: Should be "rda,8810pl-intc".
+- reg: Specifies base physical address of the registers set.
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+
+The interrupt sources are as follows:
+
+ID	Name
+------------
+0:	PULSE_DUMMY
+1:	I2C
+2:	NAND_NFSC
+3:	SDMMC1
+4:	SDMMC2
+5:	SDMMC3
+6:	SPI1
+7:	SPI2
+8:	SPI3
+9:	UART1
+10:	UART2
+11:	UART3
+12:	GPIO1
+13:	GPIO2
+14:	GPIO3
+15:	KEYPAD
+16:	TIMER
+17:	TIMEROS
+18:	COMREG0
+19:	COMREG1
+20:	USB
+21:	DMC
+22:	DMA
+23:	CAMERA
+24:	GOUDA
+25:	GPU
+26:	VPU_JPG
+27:	VPU_HOST
+28:	VOC
+29:	AUIFC0
+30:	AUIFC1
+31:	L2CC
+
+Example:
+		apb at 20800000 {
+			compatible = "simple-bus";
+			...
+			intc: interrupt-controller at 0 {
+				compatible = "rda,8810pl-intc";
+				reg = <0x0 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
-- 
2.17.1
