From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:39 +0800
Subject: [PATCH 08/16] ARM: imx: leave irq_base of wm8350_platform_data
 uninitialized
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit d1738ae (mfd: Allocate wm835x irq descs dynamically) being
in the tree, there is no need to initialize irq_base field of struct
wm8350_platform_data.  Remove it to save one reference to macro
MXC_BOARD_IRQ_START.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx31ads.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 6f19f98..a27a854 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -479,7 +479,6 @@ static int mx31_wm8350_init(struct wm8350 *wm8350)
 
 static struct wm8350_platform_data __initdata mx31_wm8350_pdata = {
 	.init = mx31_wm8350_init,
-	.irq_base = MXC_BOARD_IRQ_START + MXC_MAX_EXP_IO_LINES,
 };
 #endif
 
-- 
1.7.5.4
