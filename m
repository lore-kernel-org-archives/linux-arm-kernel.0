From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:03:31 +0200
Subject: [PATCH] memcg: include linux/mm.h
Message-ID: <14714191.7FdLxZ8X79@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to the memcg code added a call to virt_to_head_page,
which is declared in linux/mm.h, but this is not necessarily included
here and will cause compile errors:

include/linux/memcontrol.h:841:9: error: implicit declaration of function 'virt_to_head_page' [-Werror=implicit-function-declaration]

This adds an explicit include statement that gets rid of the error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1ead4c071978 ("memcg: simplify and inline __mem_cgroup_from_kmem")

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 47677acb4516..6d18936df7e8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -27,6 +27,7 @@
 #include <linux/vmpressure.h>
 #include <linux/eventfd.h>
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 #include <linux/writeback.h>
 
 struct mem_cgroup;
