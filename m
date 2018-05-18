From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:08 +0200
Subject: [PATCH 10/14] soc: renesas: r8a77995-sysc: Cleanups
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <a3daeedad3828cea21a50b02866ec62d98ad90ea.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Minor cleanup of artefacts caused by deriving from r8a7795-sysc.c:
  - Remove unused inclusion of <linux/sys_soc.h>,
  - Make r8a77995_areas[] const.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77995-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/soc/renesas/r8a77995-sysc.c
index f718429cab02..1b2ef415bbe1 100644
--- a/drivers/soc/renesas/r8a77995-sysc.c
+++ b/drivers/soc/renesas/r8a77995-sysc.c
@@ -10,13 +10,12 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/sys_soc.h>
 
 #include <dt-bindings/power/r8a77995-sysc.h>
 
 #include "rcar-sysc.h"
 
-static struct rcar_sysc_area r8a77995_areas[] __initdata = {
+static const struct rcar_sysc_area r8a77995_areas[] __initconst = {
 	{ "always-on",     0, 0, R8A77995_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
 	{ "ca53-scu",  0x140, 0, R8A77995_PD_CA53_SCU,  R8A77995_PD_ALWAYS_ON,
 	  PD_SCU },
-- 
2.11.0
