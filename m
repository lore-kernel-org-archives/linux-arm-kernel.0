From: b32955@freescale.com (Huang Shijie)
Date: Thu, 26 Apr 2012 18:37:12 +0800
Subject: [PATCH 2/2] ARM: MX6q: enable DMA support for UART2
In-Reply-To: <1335436632-29499-1-git-send-email-b32955@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
Message-ID: <1335436632-29499-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add uart2 for mx6q-arm2 board, and enable the DMA support for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..c9a6cb3 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -46,6 +46,14 @@
 				status = "okay";
 			};
 
+			uart2: uart at 021e8000 {
+				fsl,uart-has-rtscts;
+				fsl,enable-dma;
+				fsl,uart-dma-events = <27 28>;
+				fsl,enable-dte;
+				status = "okay";
+			};
+
 			uart4: uart at 021f0000 {
 				status = "okay";
 			};
-- 
1.7.0.4
