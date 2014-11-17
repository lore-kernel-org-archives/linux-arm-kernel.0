From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:30:00 +0000
Subject: [PATCH 4/8] ARM: reduce "Booted secondary processor" message to debug
 level
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSvw-0002ER-Ds@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the "CPUn: Booted secondary processor" message from info to debug
level.  We later print how many CPUs came online, so listing each one
is redundant, and when using hotplug, can be quite noisy.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3138d8ea9e55..7b18a1be179c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -351,7 +351,7 @@ asmlinkage void secondary_start_kernel(void)
 
 	cpu_init();
 
-	pr_info("CPU%u: Booted secondary processor\n", cpu);
+	pr_debug("CPU%u: Booted secondary processor\n", cpu);
 
 	preempt_disable();
 	trace_hardirqs_off();
-- 
1.8.3.1
