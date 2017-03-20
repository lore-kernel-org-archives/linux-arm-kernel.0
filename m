From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:43 +0100
Subject: [PATCH 04/31] ARM: dts: renesas: Switch from ARCH_SHMOBILE_MULTI to
 ARCH_RENESAS
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <9ed2d4bc5c0c244da8851ed1200605db48408a38.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 9b5ba0df4ea4 ("ARM: shmobile: Introduce ARCH_RENESAS") started
the migration from ARCH_SHMOBILE_MULTI to ARCH_RENESAS.
Update the Makefile to build DTBs for Renesas platforms to use the new
symbol, and move the Renesas section to preserve sort order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 011808490fed..96bd5ef79ec3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -673,6 +673,25 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-eb-a9mp-bbrevd.dtb \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
+dtb-$(CONFIG_ARCH_RENESAS) += \
+	emev2-kzm9d.dtb \
+	r7s72100-genmai.dtb \
+	r7s72100-rskrza1.dtb \
+	r8a73a4-ape6evm.dtb \
+	r8a7740-armadillo800eva.dtb \
+	r8a7743-sk-rzg1m.dtb \
+	r8a7745-sk-rzg1e.dtb \
+	r8a7778-bockw.dtb \
+	r8a7779-marzen.dtb \
+	r8a7790-lager.dtb \
+	r8a7791-koelsch.dtb \
+	r8a7791-porter.dtb \
+	r8a7792-blanche.dtb \
+	r8a7792-wheat.dtb \
+	r8a7793-gose.dtb \
+	r8a7794-alt.dtb \
+	r8a7794-silk.dtb \
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk1108-evb.dtb \
 	rk3036-evb.dtb \
@@ -713,25 +732,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
-	emev2-kzm9d.dtb \
-	r7s72100-genmai.dtb \
-	r7s72100-rskrza1.dtb \
-	r8a73a4-ape6evm.dtb \
-	r8a7740-armadillo800eva.dtb \
-	r8a7743-sk-rzg1m.dtb \
-	r8a7745-sk-rzg1e.dtb \
-	r8a7778-bockw.dtb \
-	r8a7779-marzen.dtb \
-	r8a7790-lager.dtb \
-	r8a7791-koelsch.dtb \
-	r8a7791-porter.dtb \
-	r8a7792-blanche.dtb \
-	r8a7792-wheat.dtb \
-	r8a7793-gose.dtb \
-	r8a7794-alt.dtb \
-	r8a7794-silk.dtb \
-	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk_nand.dtb \
-- 
2.7.0.rc3.207.g0ac5344
