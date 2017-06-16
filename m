From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 18:15:43 +0530
Subject: [PATCH 15/16] ARM: dts: dra7: Use new dra7-specific compatible string
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Message-ID: <20170616124544.15046-16-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new compatible string "ti,dra7-hsmmc" that was specifically
added for dra7 and dra72. This is required since for dra7 and dra72
processors iodelay values has to be set unlike other processors.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b9b8b4b5143a..52ce3fab483f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1035,7 +1035,7 @@
 		};
 
 		mmc1: mmc at 4809c000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
@@ -1049,7 +1049,7 @@
 		};
 
 		mmc2: mmc at 480b4000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
@@ -1061,7 +1061,7 @@
 		};
 
 		mmc3: mmc at 480ad000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
@@ -1074,7 +1074,7 @@
 		};
 
 		mmc4: mmc at 480d1000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
-- 
2.11.0
