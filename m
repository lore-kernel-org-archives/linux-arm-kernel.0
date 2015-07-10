From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 14:30:29 +0900
Subject: [PATCH] Drop owner assignment from i2c_driver (and platform
 left-overs)
Message-ID: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  ASoC: Drop owner assignment from i2c_driver
  ASoC: Drop owner assignment from platform_driver

 sound/soc/codecs/adau1373.c               | 1 -
 sound/soc/codecs/adau1701.c               | 1 -
 sound/soc/codecs/adau1761-i2c.c           | 1 -
 sound/soc/codecs/adau1781-i2c.c           | 1 -
 sound/soc/codecs/adau1977-i2c.c           | 1 -
 sound/soc/codecs/adav803.c                | 1 -
 sound/soc/codecs/ak4535.c                 | 1 -
 sound/soc/codecs/ak4641.c                 | 1 -
 sound/soc/codecs/ak4642.c                 | 1 -
 sound/soc/codecs/ak4671.c                 | 1 -
 sound/soc/codecs/alc5623.c                | 1 -
 sound/soc/codecs/alc5632.c                | 1 -
 sound/soc/codecs/cs35l32.c                | 1 -
 sound/soc/codecs/cs4265.c                 | 1 -
 sound/soc/codecs/cs4270.c                 | 1 -
 sound/soc/codecs/cs4271-i2c.c             | 1 -
 sound/soc/codecs/cs42l51-i2c.c            | 1 -
 sound/soc/codecs/cs42l52.c                | 1 -
 sound/soc/codecs/cs42l56.c                | 1 -
 sound/soc/codecs/cs42l73.c                | 1 -
 sound/soc/codecs/cs42xx8-i2c.c            | 1 -
 sound/soc/codecs/da7210.c                 | 1 -
 sound/soc/codecs/da7213.c                 | 1 -
 sound/soc/codecs/da732x.c                 | 1 -
 sound/soc/codecs/da9055.c                 | 1 -
 sound/soc/codecs/isabelle.c               | 1 -
 sound/soc/codecs/lm4857.c                 | 1 -
 sound/soc/codecs/lm49453.c                | 1 -
 sound/soc/codecs/max9768.c                | 1 -
 sound/soc/codecs/max98088.c               | 1 -
 sound/soc/codecs/max98090.c               | 1 -
 sound/soc/codecs/max98095.c               | 1 -
 sound/soc/codecs/max9850.c                | 1 -
 sound/soc/codecs/max9877.c                | 1 -
 sound/soc/codecs/max98925.c               | 1 -
 sound/soc/codecs/ml26124.c                | 1 -
 sound/soc/codecs/pcm1681.c                | 1 -
 sound/soc/codecs/pcm512x-i2c.c            | 1 -
 sound/soc/codecs/rt286.c                  | 1 -
 sound/soc/codecs/rt5631.c                 | 1 -
 sound/soc/codecs/rt5640.c                 | 1 -
 sound/soc/codecs/rt5645.c                 | 1 -
 sound/soc/codecs/rt5651.c                 | 1 -
 sound/soc/codecs/rt5670.c                 | 1 -
 sound/soc/codecs/rt5677.c                 | 1 -
 sound/soc/codecs/sgtl5000.c               | 1 -
 sound/soc/codecs/ssm2518.c                | 1 -
 sound/soc/codecs/ssm2602-i2c.c            | 1 -
 sound/soc/codecs/ssm4567.c                | 1 -
 sound/soc/codecs/sta32x.c                 | 1 -
 sound/soc/codecs/sta350.c                 | 1 -
 sound/soc/codecs/sta529.c                 | 1 -
 sound/soc/codecs/tas2552.c                | 1 -
 sound/soc/codecs/tas5086.c                | 1 -
 sound/soc/codecs/tfa9879.c                | 1 -
 sound/soc/codecs/tlv320aic31xx.c          | 1 -
 sound/soc/codecs/tlv320aic32x4.c          | 1 -
 sound/soc/codecs/tlv320aic3x.c            | 1 -
 sound/soc/codecs/tlv320dac33.c            | 1 -
 sound/soc/codecs/tpa6130a2.c              | 1 -
 sound/soc/codecs/ts3a227e.c               | 1 -
 sound/soc/codecs/uda1380.c                | 1 -
 sound/soc/codecs/wm1250-ev1.c             | 1 -
 sound/soc/codecs/wm2000.c                 | 1 -
 sound/soc/codecs/wm2200.c                 | 1 -
 sound/soc/codecs/wm5100.c                 | 1 -
 sound/soc/codecs/wm8510.c                 | 1 -
 sound/soc/codecs/wm8523.c                 | 1 -
 sound/soc/codecs/wm8580.c                 | 1 -
 sound/soc/codecs/wm8711.c                 | 1 -
 sound/soc/codecs/wm8728.c                 | 1 -
 sound/soc/codecs/wm8731.c                 | 1 -
 sound/soc/codecs/wm8737.c                 | 1 -
 sound/soc/codecs/wm8741.c                 | 1 -
 sound/soc/codecs/wm8750.c                 | 1 -
 sound/soc/codecs/wm8753.c                 | 1 -
 sound/soc/codecs/wm8776.c                 | 1 -
 sound/soc/codecs/wm8804-i2c.c             | 1 -
 sound/soc/codecs/wm8900.c                 | 1 -
 sound/soc/codecs/wm8903.c                 | 1 -
 sound/soc/codecs/wm8904.c                 | 1 -
 sound/soc/codecs/wm8940.c                 | 1 -
 sound/soc/codecs/wm8955.c                 | 1 -
 sound/soc/codecs/wm8960.c                 | 1 -
 sound/soc/codecs/wm8961.c                 | 1 -
 sound/soc/codecs/wm8962.c                 | 1 -
 sound/soc/codecs/wm8971.c                 | 1 -
 sound/soc/codecs/wm8974.c                 | 1 -
 sound/soc/codecs/wm8978.c                 | 1 -
 sound/soc/codecs/wm8983.c                 | 1 -
 sound/soc/codecs/wm8985.c                 | 1 -
 sound/soc/codecs/wm8988.c                 | 1 -
 sound/soc/codecs/wm8990.c                 | 1 -
 sound/soc/codecs/wm8991.c                 | 1 -
 sound/soc/codecs/wm8993.c                 | 1 -
 sound/soc/codecs/wm8995.c                 | 1 -
 sound/soc/codecs/wm8996.c                 | 1 -
 sound/soc/codecs/wm9081.c                 | 1 -
 sound/soc/codecs/wm9090.c                 | 1 -
 sound/soc/mediatek/mt8173-max98090.c      | 1 -
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mtk-afe-pcm.c          | 1 -
 102 files changed, 102 deletions(-)

-- 
1.9.1
