From: ki0351.kim@samsung.com (Kyoungil Kim)
Date: Wed, 30 May 2012 17:29:55 +0900
Subject: [PATCH] serial: samsung: protect NULL dereference of clock name
Message-ID: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KeyYoung Park <keyyoung.park@samsung.com>

When priting the serial clock source, if clock source name is null,
kernel reference NULL point.

Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/tty/serial/samsung.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ea76b40..77484e0 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1160,7 +1160,8 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
+	return snprintf(buf, PAGE_SIZE, "* %s\n",
+			ourport->baudclk->name ?: "(null)");
 }
 
 static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
-- 
1.7.1
