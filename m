From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 16 Feb 2012 21:18:07 +0100
Subject: [PATCH 2/5] ARM: Add a printk loglevel modifier
In-Reply-To: <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1329423490-15580-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a needed followup for

	ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15

otherwise no newline is printed for !CONFIG_CPU_CP15

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Should this be folded into the

	ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15

patch? Or should it come before it?
---
 arch/arm/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 50d3df8..23893b1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -325,7 +325,7 @@ static void __init cacheid_init(void)
 		cacheid = CACHEID_VIVT;
 	}
 
-	printk("CPU: %s data cache, %s instruction cache\n",
+	printk(KERN_INFO "CPU: %s data cache, %s instruction cache\n",
 		cache_is_vivt() ? "VIVT" :
 		cache_is_vipt_aliasing() ? "VIPT aliasing" :
 		cache_is_vipt_nonaliasing() ? "PIPT / VIPT nonaliasing" : "unknown",
-- 
1.7.9
