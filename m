From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:11:59 +0000
Subject: [PATCH 8/9] usb: serial: mxuport: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <1d0403e01eb663ac195926d1976974bec5c08f12.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/serial/mxuport.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 460a406..7792407 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1137,13 +1137,9 @@ static int mxuport_port_probe(struct usb_serial_port *port)
 		return err;
 
 	/* Set interface (RS-232) */
-	err = mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
+	return mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
 				    MX_INT_RS232,
 				    port->port_number);
-	if (err)
-		return err;
-
-	return 0;
 }
 
 static int mxuport_alloc_write_urb(struct usb_serial *serial,
-- 
1.9.1
