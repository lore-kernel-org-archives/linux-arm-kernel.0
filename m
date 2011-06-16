From: premi@ti.com (Sanjeev Premi)
Date: Fri, 17 Jun 2011 02:01:00 +0530
Subject: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
Message-ID: <1308256260-15597-1-git-send-email-premi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the section mismatch warning:

  WARNING: vmlinux.o(.text+0x21118): Section mismatch
  in reference from the function pm_dbg_init() to the
  function .init.text:pwrdms_setup()
  The function pm_dbg_init() references
  the function __init pwrdms_setup().
  This is often because pm_dbg_init lacks a __init
  annotation or the annotation of pwrdms_setup is wrong.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 Applies to current linux-omap master

 arch/arm/mach-omap2/pm-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e01da45..ef33273 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -595,7 +595,7 @@ static int option_set(void *data, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
 
-static int pm_dbg_init(void)
+static int __init pm_dbg_init(void)
 {
 	int i;
 	struct dentry *d;
-- 
1.7.2.2
