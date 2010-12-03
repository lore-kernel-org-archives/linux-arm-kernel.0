From: gadiyar@ti.com (Anand Gadiyar)
Date: Sat,  4 Dec 2010 00:36:12 +0530
Subject: [PATCH -next] arm: trivial: add missing argument to printk
Message-ID: <1291403172-2438-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "ARM: CPU hotplug: move cpu_killed completion to core code"
accidentally left out an argument to a printk call. This introduces
the following build warning - fix this.

arch/arm/kernel/smp.c: In function '__cpu_die':
arch/arm/kernel/smp.c:216: warning: too few arguments for format

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: mainline/arch/arm/kernel/smp.c
===================================================================
--- mainline.orig/arch/arm/kernel/smp.c
+++ mainline/arch/arm/kernel/smp.c
@@ -213,7 +213,7 @@ static DECLARE_COMPLETION(cpu_died);
 void __cpu_die(unsigned int cpu)
 {
 	if (wait_for_completion_timeout(&cpu_died, 5000)) {
-		printk(KERN_ERR "CPU%u: cpu didn't die\n");
+		printk(KERN_ERR "CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
 	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
