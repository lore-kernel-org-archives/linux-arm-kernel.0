From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:15 +0200
Subject: [PATCHv2 3/9] dt-bindings: spi: stm32: fix example with st,
 spi-midi-ns property
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch aligns example with the optional property description,
removes status and replace spidev unvalid compatible with
Aarvark SPI Host Adapter one.

In slave mode, Aardvark SPI Host Adapter requires 4ms delay
between the end of byte n and the start of byte n+1, hence the
use of the optional property st,spi-midi-ns.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 415378b..1b3fa2c1 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -48,13 +48,12 @@ Example:
 		dma-names = "rx", "tx";
 		pinctrl-0 = <&spi2_pins_b>;
 		pinctrl-names = "default";
-		status = "okay";
 		cs-gpios = <&gpioa 11 0>;
 
-		spidev at 0 {
-			compatible = "spidev";
+		aardvark at 0 {
+			compatible = "totalphase,aardvark";
 			reg = <0>;
 			spi-max-frequency = <4000000>;
-			st,spi-midi = <4000>;
+			st,spi-midi-ns = <4000>;
 		};
 	};
-- 
1.9.1
