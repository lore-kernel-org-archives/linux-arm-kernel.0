From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 13 May 2012 16:15:19 +0300
Subject: [PATCH] ARM: OMAP4: hwspinlocks_init() should be static
Message-ID: <1336914919-20032-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse found out that hwspinlocks_init() wasn't marked static,
and it should've been.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/hwspinlock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 454dfce..8763c85 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -28,7 +28,7 @@ static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
 	.base_id = 0,
 };
 
-int __init hwspinlocks_init(void)
+static int __init hwspinlocks_init(void)
 {
 	int retval = 0;
 	struct omap_hwmod *oh;
-- 
1.7.5.4
