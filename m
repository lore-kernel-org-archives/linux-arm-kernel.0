From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 5 Aug 2012 17:39:17 +0200
Subject: [PATCH 1/2] ARM: S3C24XX: Add missing DMACH_DT_PROP
In-Reply-To: <201208051738.27728.heiko@sntech.de>
References: <201208051738.27728.heiko@sntech.de>
Message-ID: <201208051739.18355.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2b90807549 (spi: s3c64xx: add device tree support) requires
the DMACH_DT_PROP element in the dma_ch enum. It's not used on non-DT
platforms but has to be present nevertheless.

So mimic the dummy-add of DMACH_DT_PROP on s3c64xx for s3c24xx
machines, to correct the build breakage for the s3c24xx variants
using the s3c64xx-spi-driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/include/mach/dma.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/dma.h b/arch/arm/mach-s3c24xx/include/mach/dma.h
index 454831b..ee99fd5 100644
--- a/arch/arm/mach-s3c24xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c24xx/include/mach/dma.h
@@ -24,7 +24,8 @@
 */
 
 enum dma_ch {
-	DMACH_XD0,
+	DMACH_DT_PROP = -1,	/* not yet supported, do not use */
+	DMACH_XD0 = 0,
 	DMACH_XD1,
 	DMACH_SDI,
 	DMACH_SPI0,
-- 
1.7.2.3
