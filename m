From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:16 +0900
Subject: [PATCH 16/16] ARM: shmobile: r8a7778: enable multiplatform target
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <3915d36fabf143dffdf91c5372d3b0a23722af52.1425518338.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds config option and enables DTB building.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile     | 1 +
 arch/arm/mach-shmobile/Kconfig | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..c467731 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -478,6 +478,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r7s72100-genmai.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..2fb072e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -62,6 +62,10 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
 
+config ARCH_R8A7778
+	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
+
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
-- 
2.1.4
