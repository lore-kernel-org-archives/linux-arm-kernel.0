From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Sep 2013 13:00:22 +0900
Subject: [PATCH 3/5] ARM: shmobile: armadillo: fixup ether pinctrl naming
In-Reply-To: <cover.1380513421.git.horms+renesas@verge.net.au>
References: <cover.1380513421.git.horms+renesas@verge.net.au>
Message-ID: <7cd402b30a701c2b4d38a98281a00fc5e3680b13.1380513421.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

e5c9b4cd665106d9b5397114ea81a53059410b6a ("sh_eth: get R8A7740 support
out of #ifdef") exchanged sh-eth driver name to r8a7740-gether, but,
eva_pinctrl_map[] didn't follow it. Fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5bd1479..7f8f607 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1108,9 +1108,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-r8a7740",
 				  "fsib_mclk_in", "fsib"),
 	/* GETHER */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
 				  "gether_mii", "gether"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
 				  "gether_int", "gether"),
 	/* HDMI */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-r8a7740",
-- 
1.8.4
