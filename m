From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 18:02:53 +0000
Subject: [PATCH 5/5] ARM: bcm2835: use defined DMA_DREQ names instead of magic
 numbers
In-Reply-To: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
References: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457200973-11662-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Change the device tree source so that instead of magic numbers
the corresponding BCM2835_DMA_DREQ_* names are used to ease readability.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 084eda7..aec67a9 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
 #include <dt-bindings/clock/bcm2835.h>
 #include <dt-bindings/clock/bcm2835-aux.h>
+#include <dt-bindings/dma/bcm2835.h>
 #include <dt-bindings/interrupt-controller/bcm2835.h>
 #include "skeleton.dtsi"
 
@@ -134,8 +135,8 @@
 			reg = <0x7e203000 0x20>,
 			      <0x7e101098 0x02>;
 
-			dmas = <&dma 2>,
-			       <&dma 3>;
+			dmas = <&dma BCM2835_DMA_DREQ_PCM_TX>,
+			       <&dma BCM2835_DMA_DREQ_PCM_RX>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
-- 
2.1.4
