From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 16 Jan 2012 15:52:36 +0530
Subject: [PATCH 1/5] omap-serial :Make the suspend/resume functions depend on
 CONFIG_PM_SLEEP.
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1326709360-26020-2-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    The macro SET_SYSTEM_SLEEP_PM_OPS  depends CONFIG_PM_SLEEP. The patch
    defines the suspend and resume functions for CONFIG_PM_SLEEP instead of
    CONFIG_SUSPEND.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d192dcb..33e3360 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1160,7 +1160,7 @@ static struct uart_driver serial_omap_reg = {
 	.cons		= OMAP_CONSOLE,
 };
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
-- 
1.7.1
