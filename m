From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 10:47:16 +0200
Subject: [PATCH] fixup! mm: simplify reclaim path for MADV_FREE
In-Reply-To: <56273fe6.c8afc20a.628d8.ffff9ed8@mx.google.com>
References: <56273fe6.c8afc20a.628d8.ffff9ed8@mx.google.com>
Message-ID: <5799761.gmbM76C6JW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 00:33:58 kernelci. org bot wrote:
> lpc18xx_defconfig (arm) ? FAIL, 55 errors, 18 warnings, 0 section mismatches
> 
> Errors:
>     include/linux/rmap.h:274:1: error: expected declaration specifiers or '...' before '{' token
>     include/linux/uaccess.h:88:13: error: storage class specified for parameter '__probe_kernel_read'
>     include/linux/uaccess.h:99:53: error: storage class specified for parameter 'probe_kernel_write'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e4f28388eb72 ("mm: simplify reclaim path for MADV_FREE")
---
Please fold into the original patch if you don't already have this.

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 978f65066fd5..853f4f3c6742 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -270,7 +270,7 @@ int rmap_walk(struct page *page, struct rmap_walk_control *rwc);
 
 static inline int page_referenced(struct page *page, int is_locked,
 				  struct mem_cgroup *memcg,
-				  unsigned long *vm_flags,
+				  unsigned long *vm_flags)
 {
 	*vm_flags = 0;
 	return 0;
