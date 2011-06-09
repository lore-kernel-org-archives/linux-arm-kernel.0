From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 9 Jun 2011 11:50:35 +0200
Subject: [PATCH] mach-ux500: iomap PRCMU TCDM memory
Message-ID: <1307613035-1633-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCMU TCDM memory needs to be iomapped for the PRCMU to work
properly.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db5500.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index c51da69..7d940a8 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -43,6 +43,7 @@ static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_GPIO3_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GPIO4_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_PRCMU_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_PRCMU_TCDM_BASE, SZ_4K),
 };
 
 static struct resource db5500_pmu_resources[] = {
-- 
1.7.4.3
