From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Oct 2013 20:34:52 +0200
Subject: [PATCH RESEND] ASoC: kirkwood: prefer external clock over internal
 clock
Message-ID: <20131018203452.177f8693@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there is an external clock, always use this one.
This prevents the two Dove audio devices to use the same DCO clock
at different rates.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch was initialy proposed by Russell, but with an erroneous
'else if'.
---
 sound/soc/kirkwood/kirkwood-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0f3d73d..8ac89f5 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -103,7 +103,7 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 {
 	uint32_t clks_ctrl;
 
-	if (rate == 44100 || rate == 48000 || rate == 96000) {
+	if (IS_ERR(priv->extclk)) {
 		/* use internal dco for the supported rates
 		 * defined in kirkwood_i2s_dai */
 		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
