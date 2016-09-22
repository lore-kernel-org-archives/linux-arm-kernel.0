From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Thu, 22 Sep 2016 09:13:10 +0200
Subject: [PATCH v5 0/3] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Message-ID: <20160922071313.12891-1-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASoC: sun4i-codec: Introduce mechanism to detect sun7i and provide a
different regmap different compared to sun4i Allwinner A10.
 
The controls will be extended in a forthcoming patch - it is necessary
to distinguish between sun4i and sun7i controls because they have different
registers.
 
Renamed SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and renamed
SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
are actually not present on Allwinner A10.

Handle quirks by regmap config and codec and select the correct quirks
automatically.  

Danny Milosavljevic (3):
  ASoC: sun4i-codec: rename "sun4i_codec_widgets" to
    "sun4i_codec_controls" for consistency with the struct field name.
  ASoC: rename "SUN4I_CODEC_SYS_VERI" to "SUN7I_CODEC_AC_DAC_CAL";
    rename "SUN4I_CODEC_AC_MIC_PHONE_CAL" to
    "SUN7I_CODEC_AC_MIC_PHONE_CAL".
  ASoC: sun4i-codec: Add custom regmap configs for the A10 and A20
    variants.

 sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)
