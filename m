From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 24 Mar 2010 14:44:12 +0100
Subject: [PATCH] KS8695: enable console
Message-ID: <4BAA172C.2070404@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KS8695: enable console

Add add_preferred_console() to ks8695_console_init() to
enable the console

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linux-2.6/drivers/serial/serial_ks8695.c
===================================================================
--- linux-2.6.orig/drivers/serial/serial_ks8695.c
+++ linux-2.6/drivers/serial/serial_ks8695.c
@@ -650,6 +650,7 @@ static struct console ks8695_console = {
 
 static int __init ks8695_console_init(void)
 {
+	add_preferred_console(SERIAL_KS8695_DEVNAME, 0, NULL);
 	register_console(&ks8695_console);
 	return 0;
 }
