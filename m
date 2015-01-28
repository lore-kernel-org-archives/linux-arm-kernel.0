From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 16:10:28 +0100
Subject: [PATCH] eventfs: avoid unused variable warning
Message-ID: <88925492.FKoyo2trpD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An optimization patch from Chris Mason causes build warnings about
an unused variable.

The patch that broke this is currently in the akpm-current series,
so this fixup can be folded into the original patch. I was expecting
multiple people to send a patch for this, so I waited a bit at first.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 567162b87a5c5f  ("eventfd: don't take the spinlock in eventfd_poll")

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 439e6f0177f3..303ddc43dbee 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -118,7 +118,6 @@ static unsigned int eventfd_poll(struct file *file, poll_table *wait)
 {
 	struct eventfd_ctx *ctx = file->private_data;
 	unsigned int events = 0;
-	unsigned long flags;
 	unsigned int count;
 
 	poll_wait(file, &ctx->wqh, wait);
