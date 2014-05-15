From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:39:33 +0900
Subject: [PATCH v2 4/4] ARM: shmobile: marzen: Do not use workaround for scif
 devices
In-Reply-To: <1400153973-25546-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153973-25546-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153973-25546-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that SCIF devices are initialised using DT it should
not be necessary to use the work around to provide clocks any more.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index c6c133d..8da72b1 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -40,12 +40,6 @@ static void __init marzen_init_timer(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "scif0", NULL, "sh-sci.0" },
-	{ "scif1", NULL, "sh-sci.1" },
-	{ "scif2", NULL, "sh-sci.2" },
-	{ "scif3", NULL, "sh-sci.3" },
-	{ "scif4", NULL, "sh-sci.4" },
-	{ "scif5", NULL, "sh-sci.5" },
 	{ "tmu0", "fck", "sh-tmu.0" },
 };
 
-- 
1.8.5.2
