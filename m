From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 2 Oct 2018 16:00:36 +0300
Subject: [PATCH v2 2/2] ARM: dts: at91: at91sam9x5cm: fix addressable nand
 flash size
In-Reply-To: <20181002130036.25957-1-tudor.ambarus@microchip.com>
References: <20181002130036.25957-1-tudor.ambarus@microchip.com>
Message-ID: <20181002130036.25957-2-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9x5cm comes with a 2Gb NAND flash. Fix the rootfs size to
match this limit.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2:
- collect Ludovic's Acked-by

 arch/arm/boot/dts/at91sam9x5cm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 4908ee07e628..993eabe1cf7a 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -100,7 +100,7 @@
 
 						rootfs at 800000 {
 							label = "rootfs";
-							reg = <0x800000 0x1f800000>;
+							reg = <0x800000 0x0f800000>;
 						};
 					};
 				};
-- 
2.9.4
