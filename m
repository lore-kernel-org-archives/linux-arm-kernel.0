From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:30 +0100
Subject: [RFC PATCH 04/11] ARM: Add a printk loglevel modifier
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-4-git-send-email-u.kleine-koenig@pengutronix.de>
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
index 3849737..f7c0d55 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -326,7 +326,7 @@ static void __init cacheid_init(void)
 		cacheid = CACHEID_VIVT;
 	}
 
-	printk("CPU: %s data cache, %s instruction cache\n",
+	printk(KERN_INFO "CPU: %s data cache, %s instruction cache\n",
 		cache_is_vivt() ? "VIVT" :
 		cache_is_vipt_aliasing() ? "VIPT aliasing" :
 		cache_is_vipt_nonaliasing() ? "PIPT / VIPT nonaliasing" : "unknown",
-- 
1.7.8.3
