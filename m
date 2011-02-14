From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 14 Feb 2011 10:49:27 +0800
Subject: [PATCH] ARM: SAMSUNG: Drop exporting s3c24xx_ts_set_platdata
Message-ID: <1297651767.13143.3.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c24xx_ts_set_platdata is annotated __init and not used by any module,
thus don't export it.
This patch fixes below warning:

WARNING: arch/arm/plat-samsung/built-in.o(__ksymtab+0x90): Section mismatch in reference from the variable __ksymtab_s3c24xx_ts_set_platdata to the function .init.text:s3c24xx_ts_set_platdata()
The symbol s3c24xx_ts_set_platdata is exported and annotated __init
Fix this by removing the __init annotation of s3c24xx_ts_set_platdata or drop the export.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/plat-samsung/dev-ts.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
index 236ef84..3e4bd81 100644
--- a/arch/arm/plat-samsung/dev-ts.c
+++ b/arch/arm/plat-samsung/dev-ts.c
@@ -58,4 +58,3 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
 
 	s3c_device_ts.dev.platform_data = npd;
 }
-EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
-- 
1.7.2
