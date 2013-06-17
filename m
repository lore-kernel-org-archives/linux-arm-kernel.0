From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 17 Jun 2013 23:39:44 +0400
Subject: [PATCH] ARM: shmobile: BOCK-W: change Ether device name
Message-ID: <201306172339.45357.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When changing the name of Ether platform device in the commit c02f846938fe (ARM:
shmobile: r8a7778: fix Ether device name), I completely forgot that there's also
platform  device name used in bockw_pinctrl_map[], so the commit "ARM: shmobile:
BOCK-W: add Ether support" went in with the old "sh-eth" device name. Now change
it to "r8a777x-ether" in accordance with the commits that are now in  the  'net-
next.git' repository,  otherwise BOCK-W Ether support won't work in 3.11.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130617v3' tag.

 arch/arm/mach-shmobile/board-bockw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -144,7 +144,7 @@ static struct rcar_phy_platform_data usb
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a777x-ether", "pfc-r8a7778",
 				  "ether_rmii", "ether"),
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7778",
