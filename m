From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Thu, 5 Nov 2009 19:25:45 +0530
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
References: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA4B5901@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
>bounces at lists.infradead.org] On Behalf Of Catalin Marinas
>Sent: Thursday, November 05, 2009 4:35 AM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Sascha Hauer; Uwe Kleine-K?nig
>Subject: [RFC PATCH] Add an earlyprintk debug console
>
>This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
>using the printch asm function.
>
>The patch is based on the original work by Sascha Hauer.

Nice work...
Linux-omap has been using for couple of years this hackery, which finally has a solution now:

diff --git a/kernel/printk.c b/kernel/printk.c
index f38b07f..1def076 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -36,6 +36,10 @@

+#ifdef CONFIG_DEBUG_LL
+       printascii(printk_buf);
+#endif

        p = printk_buf;


>
>Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>Cc: Sascha Hauer <s.hauer@pengutronix.de>
>Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>---
