From: akpm@linux-foundation.org (akpm at linux-foundation.org)
Date: Wed, 08 Feb 2012 12:42:24 -0800
Subject: [patch 1/2] arch/arm/mach-ux500/mbox-db5500.c: world-writable sysfs
 fifo file
Message-ID: <20120208204224.EE758A03DE@akpm.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasiliy Kulikov <segoon@openwall.com>
Subject: arch/arm/mach-ux500/mbox-db5500.c: world-writable sysfs fifo file

Don't allow everybody to use a modem.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-ux500/mbox-db5500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm/mach-ux500/mbox-db5500.c~arch-arm-mach-ux500-mbox-db5500c-world-writable-sysfs-fifo-file arch/arm/mach-ux500/mbox-db5500.c
--- a/arch/arm/mach-ux500/mbox-db5500.c~arch-arm-mach-ux500-mbox-db5500c-world-writable-sysfs-fifo-file
+++ a/arch/arm/mach-ux500/mbox-db5500.c
@@ -168,7 +168,7 @@ static ssize_t mbox_read_fifo(struct dev
 	return sprintf(buf, "0x%X\n", mbox_value);
 }
 
-static DEVICE_ATTR(fifo, S_IWUGO | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
+static DEVICE_ATTR(fifo, S_IWUSR | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
 
 static int mbox_show(struct seq_file *s, void *data)
 {
_
