From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 17 Mar 2016 15:24:33 +0000
Subject: [PATCH 3/3] ARM: bcm2835: add interrupt-names and apply correct
 mapping
In-Reply-To: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
References: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1458228273-15591-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add interrupt-names properties to dt and apply the correct
mapping between irq and dma channels.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 971e741..a8342f6 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -46,9 +46,29 @@
 				     <1 24>,
 				     <1 25>,
 				     <1 26>,
+				     /* dma channel 11-14 share one irq */
 				     <1 27>,
+				     <1 27>,
+				     <1 27>,
+				     <1 27>,
+				     /* unused shared irq for all channels */
 				     <1 28>;
-
+			interrupt-names = "dma0",
+					  "dma1",
+					  "dma2",
+					  "dma3",
+					  "dma4",
+					  "dma5",
+					  "dma6",
+					  "dma7",
+					  "dma8",
+					  "dma9",
+					  "dma10",
+					  "dma11",
+					  "dma12",
+					  "dma13",
+					  "dma14",
+					  "dma-shared-all";
 			#dma-cells = <1>;
 			brcm,dma-channel-mask = <0x7f35>;
 		};
--
2.1.4
