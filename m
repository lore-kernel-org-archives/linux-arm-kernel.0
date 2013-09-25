From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Sep 2013 16:30:19 +0800
Subject: [PATCH 1/5] ARM: imx: add soc revision helper functions
In-Reply-To: <1380097823-29027-1-git-send-email-shawn.guo@linaro.org>
References: <1380097823-29027-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1380097823-29027-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to what we do for cpu type, the patch adds helper functions
imx_set_soc_revision() and imx_get_soc_revision() to maintain
imx_soc_revision in cpu.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h |    2 ++
 arch/arm/mach-imx/cpu.c    |   12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4517fd7..d87fff1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -81,6 +81,8 @@ extern int imx6q_revision(void);
 extern int mx53_display_revision(void);
 extern void imx_set_aips(void __iomem *);
 extern int mxc_device_init(void);
+void imx_set_soc_revision(unsigned int rev);
+unsigned int imx_get_soc_revision(void);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index e70e3ac..51f6c51 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -8,11 +8,23 @@
 unsigned int __mxc_cpu_type;
 EXPORT_SYMBOL(__mxc_cpu_type);
 
+static unsigned int imx_soc_revision;
+
 void mxc_set_cpu_type(unsigned int type)
 {
 	__mxc_cpu_type = type;
 }
 
+void imx_set_soc_revision(unsigned int rev)
+{
+	imx_soc_revision = rev;
+}
+
+unsigned int imx_get_soc_revision(void)
+{
+	return imx_soc_revision;
+}
+
 void imx_print_silicon_rev(const char *cpu, int srev)
 {
 	if (srev == IMX_CHIP_REVISION_UNKNOWN)
-- 
1.7.9.5
