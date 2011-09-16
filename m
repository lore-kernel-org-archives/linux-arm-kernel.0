From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:16 -0400
Subject: [PATCH 05/19] ARM: plat-omap: don't define OMAP1_SRAM_VA in terms of
	VMALLOC_END
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

... as it is going to move away.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/plat-omap/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 363c91e44e..6835b89097 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -41,7 +41,7 @@
 #endif
 
 #define OMAP1_SRAM_PA		0x20000000
-#define OMAP1_SRAM_VA		VMALLOC_END
+#define OMAP1_SRAM_VA		0xd8000000
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
 #define OMAP2_SRAM_VA		0xfe400000
 #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
-- 
1.7.7-rc0
