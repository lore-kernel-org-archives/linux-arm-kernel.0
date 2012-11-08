From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:18 +0100
Subject: [PATCH 2/7] ARM: samsung: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352360783-17523-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/common.c |    1 -
 arch/arm/mach-s5p64x0/common.c |    2 --
 arch/arm/mach-s5pv210/common.c |    2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index be746e3..aef303b 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -155,7 +155,6 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 	iotable_init(mach_desc, size);
-	init_consistent_dma_size(SZ_8M);
 
 	/* detect cpu id */
 	s3c64xx_init_cpu();
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 111e404..8ae5800 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -187,7 +187,6 @@ void __init s5p6440_map_io(void)
 	s5p6440_default_sdhci2();
 
 	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
-	init_consistent_dma_size(SZ_8M);
 }
 
 void __init s5p6450_map_io(void)
@@ -202,7 +201,6 @@ void __init s5p6450_map_io(void)
 	s5p6450_default_sdhci2();
 
 	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
-	init_consistent_dma_size(SZ_8M);
 }
 
 /*
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index a0c50ef..9dfe93e 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -169,8 +169,6 @@ void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 
 void __init s5pv210_map_io(void)
 {
-	init_consistent_dma_size(14 << 20);
-
 	/* initialise device information early */
 	s5pv210_default_sdhci0();
 	s5pv210_default_sdhci1();
-- 
1.7.9.5
