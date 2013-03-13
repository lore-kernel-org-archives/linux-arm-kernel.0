From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 13:35:45 +0800
Subject: [PATCH 1/2] ARM: imx: remove duplicated function declaration
Message-ID: <1363152946-15378-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 13eed98 (arm/imx6q: add device tree machine support) added
duplicated function declaration for imx_enable_cpu() and
imx_set_cpu_jump().  Remove them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5a800bf..048e6c8 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -122,8 +122,6 @@ static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
 static inline void imx_scu_standby_enable(void) {}
 #endif
-extern void imx_enable_cpu(int cpu, bool enable);
-extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_src_init(void);
 extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
-- 
1.7.9.5
