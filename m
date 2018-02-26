From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 26 Feb 2018 17:05:00 +0200
Subject: [PATCH 2/2] ARM: dts: am43xx: add emif interrupt info
In-Reply-To: <1519657500-15490-1-git-send-email-t-kristo@ti.com>
References: <1519657500-15490-1-git-send-email-t-kristo@ti.com>
Message-ID: <1519657500-15490-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMIF instance on am43xx supports interrupts, so add the info for
completeness sake. Right now, the driver does not use this for anything,
but it is possible it would be used in future.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 964f3ef..5ebf911 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -237,6 +237,7 @@
 			compatible = "ti,emif-am4372";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		edma: edma at 49000000 {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
