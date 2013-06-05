From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:58 +0900
Subject: [PATCH 127/130] ARM: shmobile: kzm9g: tidyup FSI pinctrl
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-128-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh73a0 needs "sh_fsi2", not "sh_fsi2.0"

Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index fc4ca9b..1fdf05c 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -663,13 +663,13 @@ static unsigned long pin_pullup_conf[] = {
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
 	/* FSIA (AK4648) */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
 				  "fsia_mclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
 				  "fsia_sclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
 				  "fsia_data_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
 				  "fsia_data_out", "fsia"),
 	/* I2C3 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
-- 
1.8.2.1
