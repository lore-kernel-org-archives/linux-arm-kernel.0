From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 2 Jul 2018 07:17:07 -0500
Subject: [PATCH] ASoC: pxa-ssp: mark expected switch fall-through
Message-ID: <20180702121707.GA15015@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/pxa/pxa-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 01d5469..65828d4 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -533,6 +533,7 @@ static int pxa_ssp_configure_dai_fmt(struct ssp_priv *priv)
 
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |= SSPSP_FSRT;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_B:
 		sscr0 |= SSCR0_MOD | SSCR0_PSP;
 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
-- 
2.7.4
