From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 31 Oct 2016 10:04:19 +0800
Subject: [PATCH RESEND] tty: amba-pl011: Add earlycon support for SBSA UART
In-Reply-To: <20161030133139.GA1595@kroah.com>
References: <20161030133139.GA1595@kroah.com>
Message-ID: <1477879459-62421-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare an OF early console for SBSA UART so that the early console device
can be specified via the "stdout-path" property in device-tree.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e2c33b9..a4a0b3d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2357,6 +2357,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
1.7.12.4
