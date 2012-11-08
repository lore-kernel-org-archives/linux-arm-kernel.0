From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:22 +0100
Subject: [PATCH 6/7] ARM: u300: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352360783-17523-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b8efac4..d8632eb 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -82,8 +82,6 @@ static struct map_desc u300_io_desc[] __initdata = {
 static void __init u300_map_io(void)
 {
 	iotable_init(u300_io_desc, ARRAY_SIZE(u300_io_desc));
-	/* We enable a real big DMA buffer if need be. */
-	init_consistent_dma_size(SZ_4M);
 }
 
 /*
-- 
1.7.9.5
