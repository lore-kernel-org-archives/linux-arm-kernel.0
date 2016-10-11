From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Oct 2016 09:47:04 +0200
Subject: latest version of bluetooth for n950?
Message-ID: <20161011074704.GA21003@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sebastian!

I got some free cycles to play with n900 and bluetooth. There's still
some unrelated config option that breaks even the old vesion of
patches, but I'm ready for more debugging now.

Could I have the latest version of the (clean) bluetooth patch? I have
feeling it might work with the right config option, and would like to
try.

For the record, here's working .config and the tricky tricky oneliner
that took me week to figure out.

Best regards,
									Pavel

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index b4c0484..1304009 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -32,7 +32,7 @@
 
 #define UART_IIR	2	/* In:  Interrupt ID Register */
 #define UART_IIR_NO_INT		0x01 /* No interrupts pending */
-#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
+#define UART_IIR_ID		0x06 /* Mask for the interrupt ID */
 #define UART_IIR_MSI		0x00 /* Modem status interrupt */
 #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
 #define UART_IIR_RDI		0x04 /* Receiver data interrupt */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 24468 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/c0992560/attachment-0001.gz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/c0992560/attachment-0001.sig>
