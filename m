From: olof@lixom.net (Olof Johansson)
Date: Sun,  4 Aug 2013 21:09:53 -0700
Subject: [PATCH 3/3] ARM: vexpress: don't print virtual address in dmesg
In-Reply-To: <1375675793-16492-1-git-send-email-olof@lixom.net>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
Message-ID: <1375675793-16492-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing out the virtual address of an ioremap in dmesg makes no real
sense. Just drop it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-vexpress/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 30cfa9f..1001c6c 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -219,7 +219,7 @@ static int __init ve_spc_probe(void)
 	 */
 	sync_cache_w(info);
 	sync_cache_w(&info);
-	pr_info("vexpress-spc loaded at %p\n", info->baseaddr);
+
 	return 0;
 
 mem_free:
-- 
1.8.1.192.gc4361b8
