From: shengyong1@huawei.com (Sheng Yong)
Date: Thu, 11 Sep 2014 19:27:30 +0800
Subject: [PATCH] ARM: remove unused variables
Message-ID: <1410434850-6656-1-git-send-email-shengyong1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 6fc31d54, __lookup_machine_type was removed.  And the related
variables, MACHINFO_TYPE, MACHINFO_NAME, SIZEOF_MACHINE_DESC, are no longer
used. So let's remove them.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 arch/arm/kernel/asm-offsets.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 713e807..14a8e34 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -123,10 +123,6 @@ int main(void)
   BLANK();
   DEFINE(SYS_ERROR0,		0x9f0000);
   BLANK();
-  DEFINE(SIZEOF_MACHINE_DESC,	sizeof(struct machine_desc));
-  DEFINE(MACHINFO_TYPE,		offsetof(struct machine_desc, nr));
-  DEFINE(MACHINFO_NAME,		offsetof(struct machine_desc, name));
-  BLANK();
   DEFINE(PROC_INFO_SZ,		sizeof(struct proc_info_list));
   DEFINE(PROCINFO_INITFUNC,	offsetof(struct proc_info_list, __cpu_flush));
   DEFINE(PROCINFO_MM_MMUFLAGS,	offsetof(struct proc_info_list, __cpu_mm_mmu_flags));
-- 
1.7.9.5
