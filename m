From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 11 Jun 2014 18:14:38 +0800
Subject: [PATCH v2 0/4] ASoC: atmel_ssc: enable fslen extension feature
Message-ID: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On at91sam9rl, at91sam9g10, at91sam9g20, at91sam9g45 and newer
SoCs, the SSC peripheral supports frame sync length extension
feature. When SSC works as master, it can generate frame sync
lenght larger than 16 bits. After enable this feature, it can
playback 24/32 bits audio clips.

Changes in v2:
  - Using compatible string to distinguish whether SSC supports
    frame sync length extension to replace check IP version.
  - Add related modification for dts file.

Bo Shen (4):
  ASoC: atmel-ssc: distinguish whether SSC supports fslen ext
  ASoC: atmel_ssc_dai: enable fslen extension feature
  dts: atmel: at91sam9rl: switch ssc compatible string
  dts: atmel: at91sam9g20: switch ssc compatible string

 arch/arm/boot/dts/at91sam9g20.dtsi |  4 ++++
 arch/arm/boot/dts/at91sam9rl.dtsi  |  4 ++--
 drivers/misc/atmel-ssc.c           | 13 +++++++++++++
 include/linux/atmel-ssc.h          | 13 +++++++++++++
 sound/soc/atmel/atmel_ssc_dai.c    | 34 ++++++++++++++++++----------------
 5 files changed, 50 insertions(+), 18 deletions(-)

-- 
1.8.5.2
