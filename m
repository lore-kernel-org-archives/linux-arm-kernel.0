From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:26:09 +0900
Subject: [PATCH 4/4] ARM: mach-shmobile: sh73a0: allow unplugging of CPU0
In-Reply-To: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613569-26981-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

sh73a0 deals fine with disabling any core, so we should permit it.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 9812ea3..acb46a9 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -143,6 +143,6 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= sh73a0_cpu_kill,
 	.cpu_die		= sh73a0_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable,
+	.cpu_disable		= shmobile_cpu_disable_any,
 #endif
 };
-- 
1.7.10.4
