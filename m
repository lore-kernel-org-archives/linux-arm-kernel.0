From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Aug 2013 08:34:39 +0200
Subject: [PATCH] [TRIVIAL] ARM: msm: fix compilation error in gpiomux
Message-ID: <1375857279-18082-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compilation error in gpiomux (CONFIG_MSM_GPIOMUX=y):
arch/arm/mach-msm/gpiomux.c:24:13: error: static declaration of
	?__msm_gpiomux_write? follows non-static declaration
arch/arm/mach-msm/gpiomux.h:85:6: note: previous declaration of
	?__msm_gpiomux_write? was here

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-msm/gpiomux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/gpiomux.c b/arch/arm/mach-msm/gpiomux.c
index 2b8e2d2..4110b82 100644
--- a/arch/arm/mach-msm/gpiomux.c
+++ b/arch/arm/mach-msm/gpiomux.c
@@ -21,7 +21,7 @@
 
 static DEFINE_SPINLOCK(gpiomux_lock);
 
-static void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val)
+void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val)
 {
 	unsigned tlmm_config  = (val & ~GPIOMUX_CTL_MASK) |
 				((gpio & 0x3ff) << 4);
-- 
1.7.9.5
