From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 May 2014 13:21:43 +0200
Subject: [PATCH] ASoC: max98090: Add NI/MI values for user pclk 19.2 MHz
Message-ID: <1400757703-24431-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Zhen <zhen1.chen@samsung.com>

This patch adds the clock divisor and multiplier NI, MI values for audio
sampling frequencies 44100 and 48000 Hz and PCLK 19.2 MHz. This is useful
for the Odroid X2/U2 boards when the codec works in master mode and its
MCLK clock is fed from the I2S CDCLK output.

Signed-off-by: Chen Zhen <zhen1.chen@samsung.com>
[s.nawrocki at samsung.com: edited the commit description]
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/codecs/max98090.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f7b0b37..ea44471 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1544,19 +1544,19 @@ static const int lrclk_rates[] = {
 };
 
 static const int user_pclk_rates[] = {
-	13000000, 13000000
+	13000000, 13000000, 19200000, 19200000,
 };
 
 static const int user_lrclk_rates[] = {
-	44100, 48000
+	44100, 48000, 44100, 48000,
 };
 
 static const unsigned long long ni_value[] = {
-	3528, 768
+	3528, 768, 441, 8
 };
 
 static const unsigned long long mi_value[] = {
-	8125, 1625
+	8125, 1625, 1500, 25
 };
 
 static void max98090_configure_bclk(struct snd_soc_codec *codec)
-- 
1.7.9.5
