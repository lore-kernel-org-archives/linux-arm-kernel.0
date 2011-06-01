From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 1 Jun 2011 18:23:24 +0200
Subject: [PATCH v2 1/3] Fix missing struct for s3c2410_dma_chan in
	s3c2410_dma_suspend_chan
In-Reply-To: <201106011821.38091.heiko@sntech.de>
References: <201106011821.38091.heiko@sntech.de>
Message-ID: <201106011823.25052.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2410_dma_chan is not a type itself, so struct is required.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index c10d10c..2abf966 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1199,7 +1199,7 @@ EXPORT_SYMBOL(s3c2410_dma_getposition);
 
 #ifdef CONFIG_PM
 
-static void s3c2410_dma_suspend_chan(s3c2410_dma_chan *cp)
+static void s3c2410_dma_suspend_chan(struct s3c2410_dma_chan *cp)
 {
        printk(KERN_DEBUG "suspending dma channel %d\n", cp->number);
 
-- 
1.7.1
