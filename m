From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri,  4 Feb 2011 19:34:55 +0200
Subject: [PATCH] ep93xx: correct the end address of the AC97 memory resource
Message-ID: <1296840895-21410-1-git-send-email-mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last register is at offset 0xa8 making the resource end to be 0xac - 1
instead of 0xb0 - 1.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index ffdf87b..8207954 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -838,7 +838,7 @@ EXPORT_SYMBOL(ep93xx_i2s_release);
 static struct resource ep93xx_ac97_resources[] = {
 	{
 		.start	= EP93XX_AAC_PHYS_BASE,
-		.end	= EP93XX_AAC_PHYS_BASE + 0xb0 - 1,
+		.end	= EP93XX_AAC_PHYS_BASE + 0xac - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-- 
1.7.2.3
