From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Jul 2018 15:14:32 +0530
Subject: [PATCH] ARM: dts: da850: Add power-domains to CPPI 4.1 node
Message-ID: <20180704094432.5424-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the power-domains property to CPPI 4.1 node.

The CPPI 4.1 DMA driver uses pm_runtime to manage the clocks,
so it needs this property in order to find and enable the clock
properly.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies for v4.19/dt branch of my tree.

 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 9e05a5a709c0..07f215e7e5b8 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -637,6 +637,7 @@
 				interrupts = <58>;
 				#dma-cells = <2>;
 				#dma-channels = <4>;
+				power-domains = <&psc1 1>;
 				status = "okay";
 			};
 		};
-- 
2.16.2
