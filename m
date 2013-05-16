From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 16 May 2013 11:13:59 -0300
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e5aba13 (i2c: i2c-mxs: move to use generic DMA helper) changed
i2c-mxs.txt and drivers/i2c/busses/i2c-mxs.c to only use one I2C interrupt.

Adapt the dtsi bindings with such change.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 33389b8..2e1ba4b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -878,7 +878,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 0x2000>;
-				interrupts = <111 68>;
+				interrupts = <111>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 6>;
 				dma-names = "rx-tx";
@@ -891,7 +891,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 0x2000>;
-				interrupts = <110 69>;
+				interrupts = <110>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 7>;
 				dma-names = "rx-tx";
-- 
1.8.1.2
