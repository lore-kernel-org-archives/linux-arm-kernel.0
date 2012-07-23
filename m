From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Jul 2012 22:40:51 +0200
Subject: [PATCH 09/10 RESEND] spi: Add SSP/SPI device tree documentation
In-Reply-To: <1343076052-27312-1-git-send-email-marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
Message-ID: <1343076052-27312-10-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Attila Kinali <attila@kinali.ch>
Cc: Chris Ball <cjb@laptop.org>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/spi/mxs-spi.txt |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
new file mode 100644
index 0000000..f1263a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.txt
@@ -0,0 +1,18 @@
+* Freescale MX233/MX28 SSP/SPI
+
+Required properties:
+- compatible: Should be "fsl,<soc>-spi", where soc is "imx23" or "imx28"
+- reg: Offset and length of the register set for the device
+- interrupts: Should contain SSP interrupts (error irq first, dma irq second)
+- fsl,ssp-dma-channel: APBX DMA channel for the SSP
+
+Example:
+
+ssp0: ssp at 80010000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,imx28-spi";
+	reg = <0x80010000 2000>;
+	interrupts = <96 82>;
+	fsl,ssp-dma-channel = <0>;
+};
-- 
1.7.10.4
