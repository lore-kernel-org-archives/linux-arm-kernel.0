From: geliangtang@gmail.com (Geliang Tang)
Date: Sun,  9 Apr 2017 09:34:06 +0800
Subject: [PATCH 10/12] [media] c8sectpfe: use setup_timer
In-Reply-To: <77c0fb26d214e023a99afc948c71d6edd9284205.1490953290.git.geliangtang@gmail.com>
References: <77c0fb26d214e023a99afc948c71d6edd9284205.1490953290.git.geliangtang@gmail.com>
Message-ID: <cad969ccd0b4524d1ecdc1c5ac58e5f2009d0073.1490953290.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 7652ce2..59280ac 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -865,9 +865,8 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 	}
 
 	/* Setup timer interrupt */
-	init_timer(&fei->timer);
-	fei->timer.function = c8sectpfe_timer_interrupt;
-	fei->timer.data = (unsigned long)fei;
+	setup_timer(&fei->timer, c8sectpfe_timer_interrupt,
+		    (unsigned long)fei);
 
 	mutex_init(&fei->lock);
 
-- 
2.9.3
