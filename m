From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Sep 2014 13:14:21 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7740 legacy: Fix copied bug in comment
In-Reply-To: <cover.1411100007.git.horms+renesas@verge.net.au>
References: <cover.1411100007.git.horms+renesas@verge.net.au>
Message-ID: <8237f9e5c38098aeb8570a77bacd0fe0ebc61dfa.1411100007.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The corresponding bug in pm-sh7372.c was fixed in commit
70fe7b24672a988f ("ARM: shmobile: Do not access sh7372 A4S domain
internals directly").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index a0d44d5..94c8815 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -18,7 +18,7 @@ static int r8a7740_pd_a4s_suspend(void)
 {
 	/*
 	 * The A4S domain contains the CPU core and therefore it should
-	 * only be turned off if the CPU is in use.
+	 * only be turned off if the CPU is not in use.
 	 */
 	return -EBUSY;
 }
-- 
2.0.1
