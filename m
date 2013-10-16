From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 16 Oct 2013 21:12:54 +0800
Subject: [PATCH] ARM: imx: drop extern with function prototypes in common.h
Message-ID: <1381929174-18152-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 70dc8a4 (checkpatch: warn when using extern with function
prototypes in .h files), we will get checkpatch warning when updating
common.h following the existing convention which has extern for function
prototypes.

Let's change the convention to not use extern with function prototypes
in this header.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h |  176 ++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 9e0d03e..c1fe6d5 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -18,67 +18,67 @@ struct pt_regs;
 struct clk;
 enum mxc_cpu_pwr_mode;
 
-extern void mx1_map_io(void);
-extern void mx21_map_io(void);
-extern void mx25_map_io(void);
-extern void mx27_map_io(void);
-extern void mx31_map_io(void);
-extern void mx35_map_io(void);
-extern void mx51_map_io(void);
-extern void mx53_map_io(void);
-extern void imx1_init_early(void);
-extern void imx21_init_early(void);
-extern void imx25_init_early(void);
-extern void imx27_init_early(void);
-extern void imx31_init_early(void);
-extern void imx35_init_early(void);
-extern void imx51_init_early(void);
-extern void imx53_init_early(void);
-extern void mxc_init_irq(void __iomem *);
-extern void tzic_init_irq(void __iomem *);
-extern void mx1_init_irq(void);
-extern void mx21_init_irq(void);
-extern void mx25_init_irq(void);
-extern void mx27_init_irq(void);
-extern void mx31_init_irq(void);
-extern void mx35_init_irq(void);
-extern void mx51_init_irq(void);
-extern void mx53_init_irq(void);
-extern void imx1_soc_init(void);
-extern void imx21_soc_init(void);
-extern void imx25_soc_init(void);
-extern void imx27_soc_init(void);
-extern void imx31_soc_init(void);
-extern void imx35_soc_init(void);
-extern void imx51_soc_init(void);
-extern void imx51_init_late(void);
-extern void imx53_init_late(void);
-extern void epit_timer_init(void __iomem *base, int irq);
-extern void mxc_timer_init(void __iomem *, int);
-extern int mx1_clocks_init(unsigned long fref);
-extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
-extern int mx25_clocks_init(void);
-extern int mx27_clocks_init(unsigned long fref);
-extern int mx31_clocks_init(unsigned long fref);
-extern int mx35_clocks_init(void);
-extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
+void mx1_map_io(void);
+void mx21_map_io(void);
+void mx25_map_io(void);
+void mx27_map_io(void);
+void mx31_map_io(void);
+void mx35_map_io(void);
+void mx51_map_io(void);
+void mx53_map_io(void);
+void imx1_init_early(void);
+void imx21_init_early(void);
+void imx25_init_early(void);
+void imx27_init_early(void);
+void imx31_init_early(void);
+void imx35_init_early(void);
+void imx51_init_early(void);
+void imx53_init_early(void);
+void mxc_init_irq(void __iomem *);
+void tzic_init_irq(void __iomem *);
+void mx1_init_irq(void);
+void mx21_init_irq(void);
+void mx25_init_irq(void);
+void mx27_init_irq(void);
+void mx31_init_irq(void);
+void mx35_init_irq(void);
+void mx51_init_irq(void);
+void mx53_init_irq(void);
+void imx1_soc_init(void);
+void imx21_soc_init(void);
+void imx25_soc_init(void);
+void imx27_soc_init(void);
+void imx31_soc_init(void);
+void imx35_soc_init(void);
+void imx51_soc_init(void);
+void imx51_init_late(void);
+void imx53_init_late(void);
+void epit_timer_init(void __iomem *base, int irq);
+void mxc_timer_init(void __iomem *, int);
+int mx1_clocks_init(unsigned long fref);
+int mx21_clocks_init(unsigned long lref, unsigned long fref);
+int mx25_clocks_init(void);
+int mx27_clocks_init(unsigned long fref);
+int mx31_clocks_init(unsigned long fref);
+int mx35_clocks_init(void);
+int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
-extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
+int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
-extern int mx25_clocks_init_dt(void);
-extern int mx27_clocks_init_dt(void);
-extern int mx31_clocks_init_dt(void);
-extern int mx51_clocks_init_dt(void);
-extern int mx53_clocks_init_dt(void);
-extern struct platform_device *mxc_register_gpio(char *name, int id,
+int mx25_clocks_init_dt(void);
+int mx27_clocks_init_dt(void);
+int mx31_clocks_init_dt(void);
+int mx51_clocks_init_dt(void);
+int mx53_clocks_init_dt(void);
+struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
-extern void mxc_set_cpu_type(unsigned int type);
-extern void mxc_restart(enum reboot_mode, const char *);
-extern void mxc_arch_reset_init(void __iomem *);
-extern void mxc_arch_reset_init_dt(void);
-extern int mx53_revision(void);
-extern void imx_set_aips(void __iomem *);
-extern int mxc_device_init(void);
+void mxc_set_cpu_type(unsigned int type);
+void mxc_restart(enum reboot_mode, const char *);
+void mxc_arch_reset_init(void __iomem *);
+void mxc_arch_reset_init_dt(void);
+int mx53_revision(void);
+void imx_set_aips(void __iomem *);
+int mxc_device_init(void);
 void imx_set_soc_revision(unsigned int rev);
 unsigned int imx_get_soc_revision(void);
 void imx_init_revision_from_anatop(void);
@@ -99,8 +99,8 @@ enum mx3_cpu_pwr_mode {
 	MX3_SLEEP,
 };
 
-extern void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
-extern void imx_print_silicon_rev(const char *cpu, int srev);
+void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
+void imx_print_silicon_rev(const char *cpu, int srev);
 
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
@@ -114,57 +114,57 @@ void tzic_handle_irq(struct pt_regs *);
 #define imx51_handle_irq tzic_handle_irq
 #define imx53_handle_irq tzic_handle_irq
 
-extern void imx_enable_cpu(int cpu, bool enable);
-extern void imx_set_cpu_jump(int cpu, void *jump_addr);
-extern u32 imx_get_cpu_arg(int cpu);
-extern void imx_set_cpu_arg(int cpu, u32 arg);
-extern void v7_cpu_resume(void);
+void imx_enable_cpu(int cpu, bool enable);
+void imx_set_cpu_jump(int cpu, void *jump_addr);
+u32 imx_get_cpu_arg(int cpu);
+void imx_set_cpu_arg(int cpu, u32 arg);
+void v7_cpu_resume(void);
 #ifdef CONFIG_SMP
-extern void v7_secondary_startup(void);
-extern void imx_scu_map_io(void);
-extern void imx_smp_prepare(void);
-extern void imx_scu_standby_enable(void);
+void v7_secondary_startup(void);
+void imx_scu_map_io(void);
+void imx_smp_prepare(void);
+void imx_scu_standby_enable(void);
 #else
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
 static inline void imx_scu_standby_enable(void) {}
 #endif
-extern void imx_src_init(void);
+void imx_src_init(void);
 #ifdef CONFIG_HAVE_IMX_SRC
-extern void imx_src_prepare_restart(void);
+void imx_src_prepare_restart(void);
 #else
 static inline void imx_src_prepare_restart(void) {}
 #endif
-extern void imx_gpc_init(void);
-extern void imx_gpc_pre_suspend(void);
-extern void imx_gpc_post_resume(void);
-extern void imx_gpc_mask_all(void);
-extern void imx_gpc_restore_all(void);
-extern void imx_anatop_init(void);
-extern void imx_anatop_pre_suspend(void);
-extern void imx_anatop_post_resume(void);
-extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
-extern void imx6q_set_chicken_bit(void);
-
-extern void imx_cpu_die(unsigned int cpu);
-extern int imx_cpu_kill(unsigned int cpu);
+void imx_gpc_init(void);
+void imx_gpc_pre_suspend(void);
+void imx_gpc_post_resume(void);
+void imx_gpc_mask_all(void);
+void imx_gpc_restore_all(void);
+void imx_anatop_init(void);
+void imx_anatop_pre_suspend(void);
+void imx_anatop_post_resume(void);
+int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
+void imx6q_set_chicken_bit(void);
+
+void imx_cpu_die(unsigned int cpu);
+int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
-extern void imx6q_pm_init(void);
-extern void imx5_pm_init(void);
+void imx6q_pm_init(void);
+void imx5_pm_init(void);
 #else
 static inline void imx6q_pm_init(void) {}
 static inline void imx5_pm_init(void) {}
 #endif
 
 #ifdef CONFIG_NEON
-extern int mx51_neon_fixup(void);
+int mx51_neon_fixup(void);
 #else
 static inline int mx51_neon_fixup(void) { return 0; }
 #endif
 
 #ifdef CONFIG_CACHE_L2X0
-extern void imx_init_l2cache(void);
+void imx_init_l2cache(void);
 #else
 static inline void imx_init_l2cache(void) {}
 #endif
-- 
1.7.9.5
