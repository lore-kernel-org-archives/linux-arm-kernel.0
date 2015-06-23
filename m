From: rteysseyre@gmail.com (=?ISO-8859-1?Q?Rapha=EBl?= Teysseyre)
Date: Tue, 23 Jun 2015 15:14:40 +0200
Subject: [PATCH] gpio/xilinx: Use correct address when setting initial values.
Message-ID: <1435065280.13545.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 670209328307a198b80723a917957269a815fc32 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Rapha=C3=ABl=20Teysseyre?= <rteysseyre@gmail.com>
Date: Tue, 23 Jun 2015 14:49:31 +0200
Subject: [PATCH] gpio/xilinx: Use correct address when setting initial values.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Rapha?l Teysseyre <rteysseyre@gmail.com>
---
 drivers/gpio/gpio-xilinx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 61243d1..e544b7a 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -220,9 +220,9 @@ static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
 	if (!chip->gpio_width[1])
 		return;
 
-	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_TRI_OFFSET,
+	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_CHANNEL_OFFSET,
 		       chip->gpio_state[1]);
-	xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_TRI_OFFSET,
+	xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_CHANNEL_OFFSET,
 		       chip->gpio_dir[1]);
 }
 
-- 
1.7.1
