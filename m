From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri,  4 Feb 2011 15:23:23 +0300
Subject: [PATCH 04/20] mach-ux500: mbox-db5500: world-writable sysfs fifo file
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <9c62a32115db2dd9aec1d5b078a2a77e53dfafeb.1296818921.git.segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't allow everybody to use a modem.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile the driver, so it is not tested at all.

 arch/arm/mach-ux500/mbox-db5500.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/mbox-db5500.c b/arch/arm/mach-ux500/mbox-db5500.c
index cbf1571..402c00d 100644
--- a/arch/arm/mach-ux500/mbox-db5500.c
+++ b/arch/arm/mach-ux500/mbox-db5500.c
@@ -168,7 +168,7 @@ static ssize_t mbox_read_fifo(struct device *dev,
 	return sprintf(buf, "0x%X\n", mbox_value);
 }
 
-static DEVICE_ATTR(fifo, S_IWUGO | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
+static DEVICE_ATTR(fifo, S_IWUSR | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
 
 static int mbox_show(struct seq_file *s, void *data)
 {
-- 
1.7.0.4
