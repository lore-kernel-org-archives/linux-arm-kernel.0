From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:14 +0200
Subject: [PATCH 1/5] ARM: mvebu: remove stub implementation of CPU hotplug on
 Armada 375/38x
In-Reply-To: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1401481098-23326-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the addition of CPU hotplug support for Armada XP,
and therefore moving the existing stub functions for hotplug support,
this commit removes the reference from the SMP implementation of
Armada 375/38x to the armada_xp_cpu_die() function. Proper CPU hotplug
support for Armada 375 and 38x will be implemented at a later point.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp-a9.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 96c2c59..65f5321 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -91,9 +91,6 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 
 static struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
 	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_die		= armada_xp_cpu_die,
-#endif
 };
 
 CPU_METHOD_OF_DECLARE(mvebu_armada_375_smp, "marvell,armada-375-smp",
-- 
1.9.3
