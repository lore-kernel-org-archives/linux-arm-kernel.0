From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  6 Aug 2013 13:37:14 +0800
Subject: [PATCH 2/2] arm: prima2: drop nr_irqs in mach as we moved to linear
 irqdomain
In-Reply-To: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
References: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1375767434-19842-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we don't need nr_irqs in machine any more after we move to
linear irqdomain for sirfsoc irqchip, so drop them.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 2c70f74..e110b6d 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -42,7 +42,6 @@ static const char *atlas6_dt_match[] __initdata = {
 
 DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
-	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
 	.init_late	= sirfsoc_init_late,
@@ -59,7 +58,6 @@ static const char *prima2_dt_match[] __initdata = {
 
 DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
-	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
 	.dma_zone_size	= SZ_256M,
-- 
1.8.2.3
