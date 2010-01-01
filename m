From: jsun@junsun.net (Jun Sun)
Date: Thu, 31 Dec 2009 17:28:52 -0800
Subject: [PATCH] error message when FLAT reloc symbol is invalid, v2
Message-ID: <20100101012852.GC16887@Pogoplug>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the attachement.

Jun
-------------- next part --------------
This patch fixes a cosmetic error in printk. Text segment and data/bss
segment are allocated from two different areas. It is not meaningful to
give the diff between them in the error reporting messages.

Signed-off-by: Jun Sun <jsun@junsun.net>
---

diff -Nru linux-2.6.32.2/fs/binfmt_flat.c.orig linux-2.6.32.2/fs/binfmt_flat.c
--- linux-2.6.32.2/fs/binfmt_flat.c.orig	2009-12-18 14:27:07.000000000 -0800
+++ linux-2.6.32.2/fs/binfmt_flat.c	2009-12-26 08:22:43.000000000 -0800
@@ -355,7 +355,7 @@
 
 	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
 		printk("BINFMT_FLAT: reloc outside program 0x%x (0 - 0x%x/0x%x)",
-		       (int) r,(int)(start_brk-start_code),(int)text_len);
+		       (int) r,(int)(start_brk-start_data+text_len),(int)text_len);
 		goto failed;
 	}
 
