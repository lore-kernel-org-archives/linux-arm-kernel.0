From: eric.y.miao@gmail.com (eric.y.miao at gmail.com)
Date: Mon, 9 Aug 2010 10:03:25 +0800
Subject: [PATCH] fix GDB_MAX_REGS not defined in arch/arm/kernel/kgdb.c
Message-ID: <AANLkTik=1qGsDFfMfkP4G3S5mH3NhxycJvNL-q2RGraO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How about this?

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index 778c2f7..d6e8b4d 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -79,7 +79,7 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
struct task_struct *task)
 		return;

 	/* Initialize to zero */
-	for (regno = 0; regno < GDB_MAX_REGS; regno++)
+	for (regno = 0; regno < DBG_MAX_REG_NUM; regno++)
 		gdb_regs[regno] = 0;

 	/* Otherwise, we have only some registers from switch_to() */
