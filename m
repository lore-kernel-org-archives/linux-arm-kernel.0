From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:21 +0900
Subject: [PATCH 25/26] ARM: shmobile: bockw: remove unused
 RSND_SSI_CLK_FROM_ADG
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <c653033bae957ee141b2d27881c22e46ff26c651.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

92eba04e4bcd469518cc759ac1bf1a49acaa5cc1
(ASoC: rcar: remove RSND_SSI_CLK_FROM_ADG) removed
RSND_SSI_CLK_FROM_ADG, it is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 4 ++--
 include/sound/rcar_snd.h             | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 540f0dc..eb5b54f 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -332,11 +332,11 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
 	RSND_SSI_SET(1, 0, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE | RSND_SSI_CLK_FROM_ADG),
+	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
 	RSND_SSI_SET(0, 0, gic_iid(0x86), RSND_SSI_PLAY),
 	RSND_SSI_SET(0, 0, gic_iid(0x86), 0),
 	RSND_SSI_SET(3, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE | RSND_SSI_CLK_FROM_ADG),
+	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
diff --git a/include/sound/rcar_snd.h b/include/sound/rcar_snd.h
index 12afab1..6ce506b 100644
--- a/include/sound/rcar_snd.h
+++ b/include/sound/rcar_snd.h
@@ -34,7 +34,6 @@
  * B : SSI direction
  */
 #define RSND_SSI_CLK_PIN_SHARE		(1 << 31)
-#define RSND_SSI_CLK_FROM_ADG		(1 << 30) /* clock parent is master */
 #define RSND_SSI_SYNC			(1 << 29) /* SSI34_sync etc */
 
 #define RSND_SSI_PLAY			(1 << 24)
-- 
1.8.4
