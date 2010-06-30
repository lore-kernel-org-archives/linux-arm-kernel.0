From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:03:43 +0200
Subject: [PATCH 31/33] Removing dead MACH_U300_BS26
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <2a81bf5506ce15ac839ca4fa58dc8af4112ff531.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_U300_BS26 doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-u300/core.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 5f34eb6..653b3e0 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1561,13 +1561,6 @@ static void __init u300_init_check_chip(void)
 	printk(KERN_INFO "Initializing U300 system on %s baseband chip " \
 	       "(chip ID 0x%04x)\n", chipname, val);
 
-#ifdef CONFIG_MACH_U300_BS26
-	if ((val & 0xFF00U) != 0xc800) {
-		printk(KERN_ERR "Platform configured for BS25/BS26 " \
-		       "with DB3150 but %s detected, expect problems!",
-		       chipname);
-	}
-#endif
 #ifdef CONFIG_MACH_U300_BS330
 	if ((val & 0xFF00U) != 0xd800) {
 		printk(KERN_ERR "Platform configured for BS330 " \
-- 
1.7.0.4
