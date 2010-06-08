From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Jun 2010 22:28:11 +0200
Subject: [PATCH] ARM: correct PL080 editor mistake
Message-ID: <1276028891-20389-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This PL008 among all other variabled named PL080 doesn't seem
right. Fix it.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/hardware/pl080.h |    2 +-
 arch/arm/mach-s3c64xx/dma.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hardware/pl080.h b/arch/arm/include/asm/hardware/pl080.h
index 6a6c66b..f70e1e9 100644
--- a/arch/arm/include/asm/hardware/pl080.h
+++ b/arch/arm/include/asm/hardware/pl080.h
@@ -43,7 +43,7 @@
 
 /* Per channel configuration registers */
 
-#define PL008_Cx_STRIDE				(0x20)
+#define PL080_Cx_STRIDE				(0x20)
 #define PL080_Cx_BASE(x)			((0x100 + (x * 0x20)))
 #define PL080_Cx_SRC_ADDR(x)			((0x100 + (x * 0x20)))
 #define PL080_Cx_DST_ADDR(x)			((0x104 + (x * 0x20)))
diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 5567e03..e7d03ab 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -697,7 +697,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 		chptr->number = chno;
 		chptr->dmac = dmac;
 		chptr->regs = regptr;
-		regptr += PL008_Cx_STRIDE;
+		regptr += PL080_Cx_STRIDE;
 	}
 
 	/* for the moment, permanently enable the controller */
-- 
1.6.3.3
