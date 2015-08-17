From: nikhil.badola@freescale.com (Nikhil Badola)
Date: Mon, 17 Aug 2015 09:55:50 +0530
Subject: [PATCH 3/3][v2] arm: dts: ls1021a: Add quirk for Erratum A009116
Message-ID: <1439785550-27298-1-git-send-email-nikhil.badola@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "snps,quirk-frame-length-adjustment" property to
USB3 node for erratum A009116. This property provides
value of GFLADJ_30MHZ for post silicon frame length
adjustment.

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
Changes for v2 : 
	- updated property name

 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..50ac0d4 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -404,6 +404,7 @@
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
 		};
 	};
 };
-- 
2.1.0
