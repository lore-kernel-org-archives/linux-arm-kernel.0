From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:44 -0300
Subject: [PATCH 07/14] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address decoding window to access the BootROM should not be
allocated programatically, but instead declared in the device tree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 93f2f3a..d419fac 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -118,7 +118,6 @@ void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 	set_secondary_cpus_clock();
 	flush_cache_all();
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
-	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
 }
 
 struct smp_operations armada_xp_smp_ops __initdata = {
-- 
1.8.1.5
