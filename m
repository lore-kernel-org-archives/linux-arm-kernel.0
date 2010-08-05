From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu,  5 Aug 2010 17:19:34 +0800
Subject: [PATCH] w100fb: fix building error caused by incorrect use of writel()
Message-ID: <1280999974-2585-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Cc: stable <stable@kernel.org>
---
 drivers/video/w100fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index e66b8b1..d8b12c3 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -858,9 +858,9 @@ unsigned long w100fb_gpio_read(int port)
 void w100fb_gpio_write(int port, unsigned long value)
 {
 	if (port==W100_GPIO_PORT_A)
-		value = writel(value, remapped_regs + mmGPIO_DATA);
+		writel(value, remapped_regs + mmGPIO_DATA);
 	else
-		value = writel(value, remapped_regs + mmGPIO_DATA2);
+		writel(value, remapped_regs + mmGPIO_DATA2);
 }
 EXPORT_SYMBOL(w100fb_gpio_read);
 EXPORT_SYMBOL(w100fb_gpio_write);
-- 
1.7.1
