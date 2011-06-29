From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:19:13 +0100
Subject: [PATCH 01/23] ARM: entry: remove unused irq_prio_table macro
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1QbqvR-0002Ei-RD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms provide an empty irq_prio_table macro, and as nothing uses
this macro, it can simply be removed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcmring/include/mach/entry-macro.S |    4 ----
 arch/arm/mach-davinci/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-h720x/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S |    4 ----
 arch/arm/mach-omap2/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-pnx4008/include/mach/entry-macro.S |    5 -----
 arch/arm/plat-mxc/include/mach/entry-macro.S     |    4 ----
 7 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-bcmring/include/mach/entry-macro.S b/arch/arm/mach-bcmring/include/mach/entry-macro.S
index 7d393ca..94c950d 100644
--- a/arch/arm/mach-bcmring/include/mach/entry-macro.S
+++ b/arch/arm/mach-bcmring/include/mach/entry-macro.S
@@ -80,7 +80,3 @@
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		.macro	irq_prio_table
-		.endm
-
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
index fbdebc7..e14c0dc 100644
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ b/arch/arm/mach-davinci/include/mach/entry-macro.S
@@ -46,6 +46,3 @@
 #endif
 1002:
 		.endm
-
-		.macro	irq_prio_table
-		.endm
diff --git a/arch/arm/mach-h720x/include/mach/entry-macro.S b/arch/arm/mach-h720x/include/mach/entry-macro.S
index 6d3b917..c3948e5 100644
--- a/arch/arm/mach-h720x/include/mach/entry-macro.S
+++ b/arch/arm/mach-h720x/include/mach/entry-macro.S
@@ -57,9 +57,6 @@
 		tst     \irqstat, #1		       @ bit 0 should be set
 		.endm
 
-		.macro  irq_prio_table
-		.endm
-
 #else
 #error hynix processor selection missmatch
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
index 870227c..b725f6c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -41,7 +41,3 @@
 	rsb	\irqnr, \irqnr, #31
 	teq	\irqstat, #0
 	.endm
-
-	.macro	irq_prio_table
-	.endm
-
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index a48690b..ceb8b7e 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -165,6 +165,3 @@
 #endif
 
 #endif	/* MULTI_OMAP2 */
-
-		.macro	irq_prio_table
-		.endm
diff --git a/arch/arm/mach-pnx4008/include/mach/entry-macro.S b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
index 8003037..db7eeeb 100644
--- a/arch/arm/mach-pnx4008/include/mach/entry-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
@@ -120,8 +120,3 @@
 1003:
 		.endm
 
-
-		.macro	irq_prio_table
-		.endm
-
-
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 2e49e71..066d464 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -78,7 +78,3 @@
 	movs \irqnr, \irqnr
 #endif
 	.endm
-
-	@ irq priority table (not used)
-	.macro	irq_prio_table
-	.endm
-- 
1.7.4.4
