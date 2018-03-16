From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:43 +0100
Subject: [PATCH 46/47] ARM: dts: silk: Add r1ex24002 EEPROM to DT
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <7f8f74cd8d28f0b14b004c6c1640df439e5c2108.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the Silk board support to include U14 which is an I2C based EEPROM
hooked up to the I2C1 bus.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index f1afe2dda13a..befd0fb880cc 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -226,6 +226,12 @@
 				};
 			};
 		};
+
+		eeprom at 50 {
+			compatible = "renesas,r1ex24002", "atmel,24c02";
+			reg = <0x50>;
+			pagesize = <16>;
+		};
 	};
 };
 
-- 
2.11.0
