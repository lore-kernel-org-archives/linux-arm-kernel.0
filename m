From: mporter@ti.com (Matt Porter)
Date: Tue,  5 Mar 2013 15:53:15 -0500
Subject: [PATCH v8 9/9] ARM: dts: add AM33XX SPI DMA support
In-Reply-To: <1362516795-6346-1-git-send-email-mporter@ti.com>
References: <1362516795-6346-1-git-send-email-mporter@ti.com>
Message-ID: <1362516795-6346-10-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds DMA resources to the AM33XX SPI nodes.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index aaf44122..a13d710 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -328,6 +328,11 @@
 			interrupt = <65>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
+			dmas = <&edma 16
+				&edma 17
+				&edma 18
+				&edma 19>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			status = "disabled";
 		};
 
@@ -339,6 +344,11 @@
 			interrupt = <125>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
+			dmas = <&edma 42
+				&edma 43
+				&edma 44
+				&edma 45>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			status = "disabled";
 		};
 
-- 
1.7.9.5
