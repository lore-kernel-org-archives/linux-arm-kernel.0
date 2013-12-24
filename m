From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:19 +0900
Subject: [PATCH 02/11] serial: sh-sci: Remove baud rate calculation algorithm 5
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <6db201da2522d7dd231982ff7b83916cf4db3e41.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The algorithm isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 --
 include/linux/serial_sci.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e98a217..eb59bb2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1825,8 +1825,6 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
 		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
 	case SCBRR_ALGO_4:
 		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
-	case SCBRR_ALGO_5:
-		return (((freq * 1000 / 32) / bps) - 1);
 	}
 
 	/* Warn, but use a safe default */
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 50fe651..babc5fe 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -15,7 +15,6 @@ enum {
 	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
 	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
 	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
-	SCBRR_ALGO_5,		/* (((clk * 1000 / 32) / bps) - 1) */
 	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
 };
 
-- 
1.8.4
