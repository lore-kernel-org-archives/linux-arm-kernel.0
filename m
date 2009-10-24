From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:04:01 +0400
Subject: [PATCH 03/20] SA1100: h3600: remove IRDA bits from serial PM callback
In-Reply-To: <1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-4-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRDA is handled by separate sa1100-ir driver and has
nothing to do with sa1100_serial

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index ebb3b8d..5033c03 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -155,11 +155,8 @@ static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
 
 static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
-	if (port->mapbase == _Ser2UTCR0) { /* TODO: REMOVE THIS */
-		assign_h3600_egpio(IPAQ_EGPIO_IR_ON, !state);
-	} else if (port->mapbase == _Ser3UTCR0) {
+	if (port->mapbase == _Ser3UTCR0)
 		assign_h3600_egpio(IPAQ_EGPIO_RS232_ON, !state);
-	}
 }
 
 /*
-- 
1.6.5.1.63.ga9d7.dirty
