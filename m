From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun,  7 Oct 2012 14:02:14 +1300
Subject: [PATCH 4/4] vt8500: Fix build warning when no framebuffer selected
In-Reply-To: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1349571734-26233-5-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for framebuffer defines before declaring variables in vt8500.c
Removes a compile-time warning about unused variables.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/vt8500.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 7449886..a5bd286 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -75,8 +75,11 @@ static void vt8500_power_off(void)
 
 void __init vt8500_init(void)
 {
-	struct device_node *np, *fb;
+	struct device_node *np;
+#if defined(CONFIG_FB_VT8500) || defined(CONFIG_FB_WM8505)
+	struct device_node *fb;
 	void __iomem *gpio_base;
+#endif
 
 #ifdef CONFIG_FB_VT8500
 	fb = of_find_compatible_node(NULL, NULL, "via,vt8500-fb");
-- 
1.7.9.5
