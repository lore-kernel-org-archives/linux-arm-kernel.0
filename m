From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Oct 2012 15:49:20 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: I/O address abuse cleanup
In-Reply-To: <1350629360-27438-1-git-send-email-horms@verge.net.au>
References: <1350629360-27438-1-git-send-email-horms@verge.net.au>
Message-ID: <1350629360-27438-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

a2a47ca36642e3995e982957bc42678cf11ca6ac
(ARM: __io abuse cleanup) cleanuped __io() -> IOMEM(),
but setup-r8a7779.c was out of target,
since it directly used (void __iomem __force *) instead of __io().
This patch cleanup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 2917668..ebbffc2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -247,7 +247,7 @@ void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
-	l2x0_init((void __iomem __force *)(0xf0100000), 0x40470000, 0x82000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
 #endif
 	r8a7779_pm_init();
 
-- 
1.7.10.4
