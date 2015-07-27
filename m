From: long.wanglong@huawei.com (Wang Long)
Date: Mon, 27 Jul 2015 02:32:53 +0000
Subject: [PATCH] arm64: mm: add __init section marker to free_initrd_mem
Message-ID: <1437964373-232164-1-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not needed after booting, this patch moves the
free_initrd_mem() function to the __init section.

This patch also make keep_initrd __initdata, to reduce kernel
size.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ad87ce8..f5c0680 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -358,9 +358,9 @@ void free_initmem(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 
-static int keep_initrd;
+static int keep_initrd __initdata;
 
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (!keep_initrd)
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
-- 
1.8.3.4
