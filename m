From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:27:23 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva-reference: fix compiler warning
In-Reply-To: <cover.1375345067.git.horms+renesas@verge.net.au>
References: <cover.1375345067.git.horms+renesas@verge.net.au>
Message-ID: <ab40900b70dc31a64f23b1b4dbb0917afb039775.1375345067.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Fix the compiler warning:

arch/arm/mach-shmobile/board-armadillo800eva-reference.c:196:2: warning: initialization from incompatible pointer type [enabled by default]
arch/arm/mach-shmobile/board-armadillo800eva-reference.c:196:2: warning: (near initialization for '__mach_desc_ARMADILLO800EVA_DT.restart') [enabled by default]

While at it also remove superfluous parenthesis.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 03b85fe..8f677df 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -190,10 +190,10 @@ static void __init eva_init(void)
 }
 
 #define RESCNT2 IOMEM(0xe6188020)
-static void eva_restart(char mode, const char *cmd)
+static void eva_restart(enum reboot_mode mode, const char *cmd)
 {
 	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
+	writel(1 << 31, RESCNT2);
 }
 
 static const char *eva_boards_compat_dt[] __initdata = {
-- 
1.8.3.2
