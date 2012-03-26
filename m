From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 26 Mar 2012 17:13:58 +0530
Subject: [PATCH 2/5] SPEAr3xx: Replace printk() with pr_*()
In-Reply-To: <cover.1332762103.git.viresh.kumar@st.com>
References: <cover.1332762103.git.viresh.kumar@st.com>
Message-ID: <e6e6b8c9f3298ac9524a480f1085d7e0ce06b7af.1332762103.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For better print logs/messages, it is advisable to use pr_*() routines instead
of directly calling printks. This patch removes direct calling of printks for
spear3xx.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    8 +++++---
 arch/arm/mach-spear3xx/spear310.c |   13 +++++++------
 arch/arm/mach-spear3xx/spear320.c |   11 ++++++-----
 arch/arm/mach-spear3xx/spear3xx.c |    2 ++
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index f7db668..adee72b 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define pr_fmt(fmt) "SPEAr300: " fmt
+
 #include <linux/types.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
@@ -447,7 +449,7 @@ void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 	if (shirq_ras1.regs.base) {
 		ret = spear_shirq_register(&shirq_ras1);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ\n");
+			pr_err("Error registering Shared IRQ\n");
 	}
 
 	/* pmx initialization */
@@ -459,8 +461,8 @@ void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 	if (pmx_driver.base) {
 		ret = pmx_register(&pmx_driver);
 		if (ret)
-			printk(KERN_ERR "padmux: registration failed. err no"
-					": %d\n", ret);
+			pr_err("padmux: registration failed. err no: %d\n",
+					ret);
 		/* Free Mapping, device selection already done */
 		iounmap(pmx_driver.base);
 	}
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index febaa6f..b7c2876 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define pr_fmt(fmt) "SPEAr310: " fmt
+
 #include <linux/ptrace.h>
 #include <asm/irq.h>
 #include <plat/shirq.h>
@@ -274,25 +276,25 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		shirq_ras1.regs.base = base;
 		ret = spear_shirq_register(&shirq_ras1);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 1\n");
+			pr_err("Error registering Shared IRQ 1\n");
 
 		/* shirq 2 */
 		shirq_ras2.regs.base = base;
 		ret = spear_shirq_register(&shirq_ras2);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 2\n");
+			pr_err("Error registering Shared IRQ 2\n");
 
 		/* shirq 3 */
 		shirq_ras3.regs.base = base;
 		ret = spear_shirq_register(&shirq_ras3);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 3\n");
+			pr_err("Error registering Shared IRQ 3\n");
 
 		/* shirq 4 */
 		shirq_intrcomm_ras.regs.base = base;
 		ret = spear_shirq_register(&shirq_intrcomm_ras);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 4\n");
+			pr_err("Error registering Shared IRQ 4\n");
 	}
 
 	/* pmx initialization */
@@ -303,6 +305,5 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 
 	ret = pmx_register(&pmx_driver);
 	if (ret)
-		printk(KERN_ERR "padmux: registration failed. err no: %d\n",
-				ret);
+		pr_err("padmux: registration failed. err no: %d\n", ret);
 }
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index deaaf19..7bd39c0 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define pr_fmt(fmt) "SPEAr320: " fmt
+
 #include <linux/ptrace.h>
 #include <asm/irq.h>
 #include <plat/shirq.h>
@@ -527,19 +529,19 @@ void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		shirq_ras1.regs.base = base;
 		ret = spear_shirq_register(&shirq_ras1);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 1\n");
+			pr_err("Error registering Shared IRQ 1\n");
 
 		/* shirq 3 */
 		shirq_ras3.regs.base = base;
 		ret = spear_shirq_register(&shirq_ras3);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 3\n");
+			pr_err("Error registering Shared IRQ 3\n");
 
 		/* shirq 4 */
 		shirq_intrcomm_ras.regs.base = base;
 		ret = spear_shirq_register(&shirq_intrcomm_ras);
 		if (ret)
-			printk(KERN_ERR "Error registering Shared IRQ 4\n");
+			pr_err("Error registering Shared IRQ 4\n");
 	}
 
 	/* pmx initialization */
@@ -550,6 +552,5 @@ void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 
 	ret = pmx_register(&pmx_driver);
 	if (ret)
-		printk(KERN_ERR "padmux: registration failed. err no: %d\n",
-				ret);
+		pr_err("padmux: registration failed. err no: %d\n", ret);
 }
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index b1733c3..a236925 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define pr_fmt(fmt) "SPEAr3xx: " fmt
+
 #include <linux/types.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
-- 
1.7.10.rc2.10.gb47606
