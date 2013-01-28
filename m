From: pavel@denx.de (Pavel Machek)
Date: Mon, 28 Jan 2013 20:36:35 +0100
Subject: [RFC] socfpga: make function static
In-Reply-To: <1359075633-13502-6-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-6-git-send-email-dinguyen@altera.com>
Message-ID: <20130128193635.GB26908@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

While moving cpu1 start address into device tree, I noticed that
sysmgr_init can be static. Trivial patch is below.

Signed-off-by: Pavel Machek <pavel@denx.de>

commit 11030de41d7da7a14ca0c77abb726d6eec3a2fb7

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 323c74a..3ebd469 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -26,7 +26,6 @@ extern void v7_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
-extern void socfpga_sysmgr_init(void);
 
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bb17810..334c330 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -68,7 +68,7 @@ const static struct of_device_id irq_match[] = {
 	{}
 };
 
-void __init socfpga_sysmgr_init(void)
+static void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
