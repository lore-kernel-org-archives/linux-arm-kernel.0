From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 17:07:17 +0530
Subject: [PATCH 2/3] serial: samsung: correct the case and default order in
 switch
In-Reply-To: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
References: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405337838-30335-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cases should comes before default in a switch.

Even if we want the case and default to share same code.
Its good to define the case first followed by default.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: gregkh at linuxfoundation.org
---
 drivers/tty/serial/samsung.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index e49a945..d98f93d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1542,8 +1542,8 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		case S3C2410_LCON_CS7:
 			*bits = 7;
 			break;
-		default:
 		case S3C2410_LCON_CS8:
+		default:
 			*bits = 8;
 			break;
 		}
-- 
1.7.9.5
