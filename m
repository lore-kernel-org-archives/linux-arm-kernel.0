From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:12 +0530
Subject: [PATCH 02/33] ARM: EXYNOS: dev-ahci: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/dev-ahci.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/dev-ahci.c b/arch/arm/mach-exynos/dev-ahci.c
index 50ce5b0..ce1aad3 100644
--- a/arch/arm/mach-exynos/dev-ahci.c
+++ b/arch/arm/mach-exynos/dev-ahci.c
@@ -236,16 +236,8 @@ static struct ahci_platform_data exynos4_ahci_pdata = {
 };
 
 static struct resource exynos4_ahci_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_SATA,
-		.end	= EXYNOS4_PA_SATA + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= EXYNOS4_IRQ_SATA,
-		.end	= EXYNOS4_IRQ_SATA,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_SATA, SZ_64K),
+	[1] = DEFINE_RES_IRQ(EXYNOS4_IRQ_SATA),
 };
 
 static u64 exynos4_ahci_dmamask = DMA_BIT_MASK(32);
-- 
1.7.4.1
