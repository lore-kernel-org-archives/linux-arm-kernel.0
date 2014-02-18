From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:28 +0800
Subject: [PATCH 2/5] ARM: prima2: platsmp: fix checkpatch issues
In-Reply-To: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
References: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1392705991-29967-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

fix the below checkpatch issues:
ERROR: code indent should use tabs where possible
141: FILE: platsmp.c:141:
+        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,$

WARNING: please, no spaces at the start of a line
141: FILE: platsmp.c:141:
+        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,$

ERROR: code indent should use tabs where possible
142: FILE: platsmp.c:142:
+        .smp_secondary_init     = sirfsoc_secondary_init,$

WARNING: please, no spaces at the start of a line
142: FILE: platsmp.c:142:
+        .smp_secondary_init     = sirfsoc_secondary_init,$

ERROR: code indent should use tabs where possible
143: FILE: platsmp.c:143:
+        .smp_boot_secondary     = sirfsoc_boot_secondary,$

WARNING: please, no spaces at the start of a line
143: FILE: platsmp.c:143:
+        .smp_boot_secondary     = sirfsoc_boot_secondary,$

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/platsmp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index e358b07..335c12e 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -138,9 +138,9 @@ static void __init sirfsoc_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct smp_operations sirfsoc_smp_ops __initdata = {
-        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
-        .smp_secondary_init     = sirfsoc_secondary_init,
-        .smp_boot_secondary     = sirfsoc_boot_secondary,
+	.smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
+	.smp_secondary_init     = sirfsoc_secondary_init,
+	.smp_boot_secondary     = sirfsoc_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die                = sirfsoc_cpu_die,
 #endif
-- 
1.7.5.4
