From: long.wanglong@huawei.com (Wang Long)
Date: Mon, 27 Jul 2015 02:24:13 +0000
Subject: [PATCH] arm: mm: add __init section marker to free_initrd_mem
Message-ID: <1437963853-230533-1-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not needed after booting, this patch moves the
free_initrd_mem() function to the __init section.

This patch also make keep_initrd __initdata, to reduce kernel
size.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 arch/arm/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8a63b4c..1eaf5d1 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -728,9 +728,9 @@ void free_initmem(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 
-static int keep_initrd;
+static int keep_initrd __initdata;
 
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (!keep_initrd) {
 		if (start == initrd_start)
-- 
1.8.3.4
