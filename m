From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 11:56:57 +0200
Subject: [PATCH 6/7] ARM: fix ordering of defaults for config ZRELADDR
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
Message-ID: <1283507818-1573-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0654afe..ed564a5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1596,8 +1596,8 @@ config ZRELADDR
 		ARCH_MMP ||\
 		ARCH_MV78XX0 ||\
 		ARCH_NOMADIK ||\
-		ARCH_NUC93X ||\
 		ARCH_NS9XXX ||\
+		ARCH_NUC93X ||\
 		ARCH_ORION5X ||\
 		ARCH_SPEAR3XX ||\
 		ARCH_SPEAR6XX ||\
@@ -1660,9 +1660,9 @@ config ZRELADDR
 	default 0x10008000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
 	default 0x70008000 if ARCH_REALVIEW && REALVIEW_HIGH_PHYS_OFFSET
 	default 0x00008000 if ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET
+	default 0x30108000 if ARCH_S3C2410 && PM_H1940
 	default 0xc0208000 if ARCH_SA1100 && SA1111
 	default 0xc0008000 if ARCH_SA1100 && !SA1111
-	default 0x30108000 if ARCH_S3C2410 && PM_H1940
 	default 0x28E08000 if ARCH_U300 && MACH_U300_SINGLE_RAM
 	default 0x48008000 if ARCH_U300 && !MACH_U300_SINGLE_RAM
 	help
-- 
1.7.1
