From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:19 +0100
Subject: [PATCH 3/7] ARM: davinci: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352360783-17523-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-davinci/common.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 64b0f65..a794f6d 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -87,8 +87,6 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 		iotable_init(davinci_soc_info.io_desc,
 				davinci_soc_info.io_desc_num);
 
-	init_consistent_dma_size(14 << 20);
-
 	/*
 	 * Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
-- 
1.7.9.5
