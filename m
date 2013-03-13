From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 13:35:46 +0800
Subject: [PATCH 2/2] ARM: imx: remove pl310_get_save_ptr() declaration
In-Reply-To: <1363152946-15378-1-git-send-email-shawn.guo@linaro.org>
References: <1363152946-15378-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1363152946-15378-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a1f1c7e (arm/imx6q: add suspend/resume support) added
declaration for a non-existing function pl310_get_save_ptr() by
mistake.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 048e6c8..d4b2f36 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -111,7 +111,6 @@ void tzic_handle_irq(struct pt_regs *);
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void v7_cpu_resume(void);
-extern u32 *pl310_get_save_ptr(void);
 #ifdef CONFIG_SMP
 extern void v7_secondary_startup(void);
 extern void imx_scu_map_io(void);
-- 
1.7.9.5
