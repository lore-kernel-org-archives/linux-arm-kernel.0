From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:43 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7740: Make r8a7740_meram_workaround()
 __init
In-Reply-To: <cover.1398216284.git.horms+renesas@verge.net.au>
References: <cover.1398216284.git.horms+renesas@verge.net.au>
Message-ID: <bb6c3d58c36adb205b4bf233fd1c4079e02a6811.1398216284.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

It's called from eva_init() only, which is __init

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index cba3a07..a177a7b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -765,7 +765,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
  *	"Media RAM (MERAM)" on r8a7740 documentation
  */
 #define MEBUFCNTR	0xFE950098
-void r8a7740_meram_workaround(void)
+void __init r8a7740_meram_workaround(void)
 {
 	void __iomem *reg;
 
-- 
1.8.5.2
