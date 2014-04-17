From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:32:09 +0900
Subject: [PATCH 1/5] ARM: shmobile: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
In-Reply-To: <cover.1397694064.git.horms+renesas@verge.net.au>
References: <cover.1397694064.git.horms+renesas@verge.net.au>
Message-ID: <9f85ff849c21b429c1e2137f2646f9cc667d8ded.1397694064.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

e1508289404ab6ca28e0dc931612600f0441c417
(ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags)
corrected SND_SOC_DAIFMT_CBx_CFx definition.
But then, Lager board was maintenanced other branch.
This patch correct SND_SOC_DAIFMT_CBx_CFx flag for lager

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f0104bf..18c7e03 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -588,14 +588,12 @@ static struct asoc_simple_card_info rsnd_card_info = {
 	.card		= "SSI01-AK4643",
 	.codec		= "ak4642-codec.2-0012",
 	.platform	= "rcar_sound",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "rcar_sound",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 		.sysclk	= 11289600,
 	},
 };
-- 
1.8.4
