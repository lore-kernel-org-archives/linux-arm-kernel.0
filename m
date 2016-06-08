From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:10:03 +0100
Subject: [PATCH] ARM: vexpress: fix missing core.h include
Message-ID: <1465405803-22718-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing declaration of vexpress_cpu_die() by
including core.h where it is defined. Fixes:

arch/arm/mach-vexpress/hotplug.c:88:6: warning: symbol 'vexpress_cpu_die' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-vexpress/hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index f2fafc1..d8f1a05 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -15,6 +15,8 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
+#include "core.h"
+
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
-- 
2.8.1
