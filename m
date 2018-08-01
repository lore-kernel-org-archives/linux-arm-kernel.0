From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:39 +0100
Subject: [PATCH 6/9] ASoC: nau8540: remove redundant variable osrate
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-7-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Variable osrate is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'osrate' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/nau8540.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 17104f8dc1a9..e3c8cd17daf2 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -362,11 +362,8 @@ static const struct snd_soc_dapm_route nau8540_dapm_routes[] = {
 
 static int nau8540_clock_check(struct nau8540 *nau8540, int rate, int osr)
 {
-	int osrate;
-
 	if (osr >= ARRAY_SIZE(osr_adc_sel))
 		return -EINVAL;
-	osrate = osr_adc_sel[osr].osr;
 
 	if (rate * osr > CLK_ADC_MAX) {
 		dev_err(nau8540->dev, "exceed the maximum frequency of CLK_ADC\n");
-- 
2.17.1
