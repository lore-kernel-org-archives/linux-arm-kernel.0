From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jul 2010 11:10:37 +0200
Subject: [PATCH 06/10 v2] ARM: S5PV210: Add fifo link definitions for FIMC and
	framebuffer
In-Reply-To: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279185041-6004-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add definition of local paths that are available on Samsung S5PV210 SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s5pv210/setup-fimc0.c       |   23 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-fimc1.c       |   23 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-fimc2.c       |   23 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fimc.h |    4 ++++
 4 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/setup-fimc0.c b/arch/arm/mach-s5pv210/setup-fimc0.c
index 0e5ef0a..b869d87 100644
--- a/arch/arm/mach-s5pv210/setup-fimc0.c
+++ b/arch/arm/mach-s5pv210/setup-fimc0.c
@@ -10,5 +10,28 @@
  */
 
 #include <plat/fimc.h>
+#include <plat/fifo.h>
+#include <linux/fb.h>
+#include <plat/fb.h>
+#include <plat/devs.h>
 
 struct samsung_plat_fimc s5p_fimc0_default_data __initdata = {};
+
+static struct s3c_fifo_link s5pv210_fimc0_win0_link = {
+	.master_dev	= &s5p_device_fimc0.dev,
+	.slave_dev	= &s3c_device_fb.dev,
+};
+
+void __init s5pv210_setup_fimc0_fb_link(void)
+{
+	struct s3c_fb_platdata *fb_pd;
+	struct samsung_plat_fimc *fimc_pd;
+
+	fimc_pd = s5p_device_fimc0.dev.platform_data;
+	fb_pd = s3c_device_fb.dev.platform_data;
+
+	if (fimc_pd && fb_pd && fb_pd->win[0]) {
+		fb_pd->win[0]->fifo_sources[0] = &s5pv210_fimc0_win0_link;
+		fimc_pd->fifo_targets[0] = &s5pv210_fimc0_win0_link;
+	}
+}
diff --git a/arch/arm/mach-s5pv210/setup-fimc1.c b/arch/arm/mach-s5pv210/setup-fimc1.c
index 80da0e7..62a7804 100644
--- a/arch/arm/mach-s5pv210/setup-fimc1.c
+++ b/arch/arm/mach-s5pv210/setup-fimc1.c
@@ -10,5 +10,28 @@
  */
 
 #include <plat/fimc.h>
+#include <plat/fifo.h>
+#include <linux/fb.h>
+#include <plat/fb.h>
+#include <plat/devs.h>
 
 struct samsung_plat_fimc s5p_fimc1_default_data __initdata = {};
+
+static struct s3c_fifo_link s5pv210_fimc1_win1_link = {
+	.master_dev	= &s5p_device_fimc1.dev,
+	.slave_dev	= &s3c_device_fb.dev,
+};
+
+void __init s5pv210_setup_fimc1_fb_link(void)
+{
+	struct s3c_fb_platdata *fb_pd;
+	struct samsung_plat_fimc *fimc_pd;
+
+	fimc_pd = s5p_device_fimc1.dev.platform_data;
+	fb_pd = s3c_device_fb.dev.platform_data;
+
+	if (fimc_pd && fb_pd && fb_pd->win[1]) {
+		fb_pd->win[1]->fifo_sources[0] = &s5pv210_fimc1_win1_link;
+		fimc_pd->fifo_targets[0] = &s5pv210_fimc1_win1_link;
+	}
+}
diff --git a/arch/arm/mach-s5pv210/setup-fimc2.c b/arch/arm/mach-s5pv210/setup-fimc2.c
index bc6a27b..1515eac 100644
--- a/arch/arm/mach-s5pv210/setup-fimc2.c
+++ b/arch/arm/mach-s5pv210/setup-fimc2.c
@@ -10,5 +10,28 @@
  */
 
 #include <plat/fimc.h>
+#include <plat/fifo.h>
+#include <linux/fb.h>
+#include <plat/fb.h>
+#include <plat/devs.h>
 
 struct samsung_plat_fimc s5p_fimc2_default_data __initdata = {};
+
+static struct s3c_fifo_link s5pv210_fimc2_win2_link = {
+	.master_dev	= &s5p_device_fimc2.dev,
+	.slave_dev	= &s3c_device_fb.dev,
+};
+
+void __init s5pv210_setup_fimc2_fb_link(void)
+{
+	struct s3c_fb_platdata *fb_pd;
+	struct samsung_plat_fimc *fimc_pd;
+
+	fimc_pd = s5p_device_fimc2.dev.platform_data;
+	fb_pd = s3c_device_fb.dev.platform_data;
+
+	if (fimc_pd && fb_pd && fb_pd->win[2]) {
+		fb_pd->win[2]->fifo_sources[0] = &s5pv210_fimc2_win2_link;
+		fimc_pd->fifo_targets[0] = &s5pv210_fimc2_win2_link;
+	}
+}
diff --git a/arch/arm/plat-samsung/include/plat/fimc.h b/arch/arm/plat-samsung/include/plat/fimc.h
index cf7d2fb..304ef42 100644
--- a/arch/arm/plat-samsung/include/plat/fimc.h
+++ b/arch/arm/plat-samsung/include/plat/fimc.h
@@ -39,5 +39,9 @@ extern void s5p_fimc0_set_platdata(struct samsung_plat_fimc *fimc);
 extern void s5p_fimc1_set_platdata(struct samsung_plat_fimc *fimc);
 extern void s5p_fimc2_set_platdata(struct samsung_plat_fimc *fimc);
 
+extern void __init s5pv210_setup_fimc0_fb_link(void);
+extern void __init s5pv210_setup_fimc1_fb_link(void);
+extern void __init s5pv210_setup_fimc2_fb_link(void);
+
 #endif /* FIMC_H_ */
 
-- 
1.7.0.4
