From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:23 +0900
Subject: [PATCH 5/5] ARM: shmobile: BOCK-W: change Ether device name
In-Reply-To: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648143-18376-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When changing the name of Ether platform device in the commit c02f846938fe (ARM:
shmobile: r8a7778: fix Ether device name), I completely forgot that there's also
platform  device name used in bockw_pinctrl_map[], so the commit "ARM: shmobile:
BOCK-W: add Ether support" went in with the old "sh-eth" device name. Now change
it to "r8a777x-ether" in accordance with the commits that are now in  the  'net-
next.git' repository,  otherwise BOCK-W Ether support won't work in 3.11.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 7d48461..ce56381 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -142,7 +142,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a777x-ether", "pfc-r8a7778",
 				  "ether_rmii", "ether"),
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7778",
-- 
1.8.2.1
