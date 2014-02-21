From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 21 Feb 2014 13:25:26 +0100
Subject: [PATCH v5 10/11] arm64: add support for reserved memory defined by
 device tree
In-Reply-To: <1392985527-6260-1-git-send-email-m.szyprowski@samsung.com>
References: <1392985527-6260-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1392985527-6260-11-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/Kconfig   |    1 +
 arch/arm64/mm/init.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc7202a..6abf15407dca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d0b4c2efda90..3fb8d50dfdaa 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -160,6 +160,7 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(base, size);
 	}
 
+	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(0);
 
 	memblock_allow_resize();
-- 
1.7.9.5
