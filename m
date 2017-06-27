From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:13 +0200
Subject: [PATCHv2 1/9] dt-bindings: spi: stm32: use SoC specific compatible
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces st,stm32-spi compatible with st,stm32h7-spi SoC
specific compatible and updates the example accondingly.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 3958bf6..415378b 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,7 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32-spi".
+- compatible: Must be "st,stm32h7-spi".
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -38,7 +38,7 @@ Example:
 	spi2: spi at 40003800 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "st,stm32-spi";
+		compatible = "st,stm32h7-spi";
 		reg = <0x40003800 0x400>;
 		interrupts = <36>;
 		clocks = <&rcc SPI2_CK>;
-- 
1.9.1
