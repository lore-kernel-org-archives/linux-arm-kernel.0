From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:22 +0900
Subject: [PATCH 05/11] serial: sh-sci: Set the UPF_FIXED_PORT flag
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <b6e4a3f18c0d289c7eed652dc0253a7f8fea27e4.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The base address, IRQ and baud rate generator parent clock rate can't be
changed by userspace. Mark the port as fixed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8c17d55..67dadbd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2248,7 +2248,7 @@ static int sci_init_single(struct platform_device *dev,
 
 	port->mapbase		= p->mapbase;
 	port->type		= p->type;
-	port->flags		= p->flags;
+	port->flags		= UPF_FIXED_PORT | p->flags;
 	port->regshift		= p->regshift;
 
 	/*
-- 
1.8.4
