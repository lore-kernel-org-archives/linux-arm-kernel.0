From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 Jun 2017 15:07:45 +0530
Subject: [PATCH v2 4/8] ARM: dts: am57xx-beagle-x15-revb1: Fix supply name
 used for MMC1 IO lines
In-Reply-To: <20170607093749.15656-1-kishon@ti.com>
References: <20170607093749.15656-1-kishon@ti.com>
Message-ID: <20170607093749.15656-5-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dt binding documentation of omap-hsmmc recommends using
"vmmc_aux" for IO supply lines. However
commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add support
for rev B1") added it as "vmmc-aux". Now that anyways it
needs to be fixed, use the generic "vqmmc" binding instead of
the deprecated "vmmc_aux".

Fixes: commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add
support for rev B1")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 39a92aff0a0d..578398c781b1 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -20,7 +20,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vdd_3v3>;
-	vmmc-aux-supply = <&ldo1_reg>;
+	vqmmc-supply = <&ldo1_reg>;
 };
 
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
-- 
2.11.0
