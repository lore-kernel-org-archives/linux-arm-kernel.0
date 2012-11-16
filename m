From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 16 Nov 2012 10:51:01 +0900
Subject: [PATCH v2 02/10] Revert "sh-sci / PM: Use power.irq_safe"
In-Reply-To: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Message-ID: <50A59C05.1090902@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 5a50a01bf0 (sh-sci / PM: Use power.irq_safe, from
Rafael J. Wysocki <rjw@sisk.pl>, 2011-08-24).

In order to get console PM work properly, we should implement uart_ops
->pm() operation, rather than sprinkle band-ading runtime PM calls in
the driver.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 526ad04..9abe977 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2116,7 +2116,6 @@ static int __devinit sci_init_single(struct platform_device *dev,
 
 		sci_init_gpios(sci_port);
 
-		pm_runtime_irq_safe(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 
-- 
1.7.12.4
