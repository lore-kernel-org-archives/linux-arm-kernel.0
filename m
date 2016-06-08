From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:06:14 +0100
Subject: [PATCH] vexpress/spc: fix missing include of spc.h
Message-ID: <1465405574-20498-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing function prototypes found in spc.h by including
the file to remove the following warnings:

arch/arm/mach-vexpress/spc.c:131:6: warning: symbol 've_spc_global_wakeup_irq' was not declared. Should it be static?
arch/arm/mach-vexpress/spc.c:156:6: warning: symbol 've_spc_cpu_wakeup_irq' was not declared. Should it be static?
arch/arm/mach-vexpress/spc.c:185:6: warning: symbol 've_spc_set_resume_addr' was not declared. Should it be static?
arch/arm/mach-vexpress/spc.c:210:6: warning: symbol 've_spc_powerdown' was not declared. Should it be static?
arch/arm/mach-vexpress/spc.c:240:5: warning: symbol 've_spc_cpu_in_wfi' was not declared. Should it be static?
arch/arm/mach-vexpress/spc.c:450:12: warning: symbol 've_spc_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-vexpress/spc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 8409cab..7d2d997 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -31,6 +31,8 @@
 
 #include <asm/cacheflush.h>
 
+#include "spc.h"
+
 #define SPCLOG "vexpress-spc: "
 
 #define PERF_LVL_A15		0x00
-- 
2.8.1
