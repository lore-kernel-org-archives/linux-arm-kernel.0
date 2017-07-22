From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 22 Jul 2017 08:53:50 +0200
Subject: [PATCH v2 0/2] ASoC: Add I2S support for Allwinner H3 SoCs
Message-ID: <20170722065352.7635-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
please find attached a series of patches to bring i2s support to the
Allwinner H3 SoC. This has been tested with the following setups:

A20 Olimex EVB connected to a pcm5102
Orange Pi 2 connected to a uda1380
Orange Pi 2 hdmi audio playback
Pine 64 connected to the audio DAC board

To get i2s working some additional patches are required which will be
delivered later. For now they have been pushed here

https://github.com/codekipper/linux-sunxi/commits/sunxi-audio-h3

I don't own a A33 device which uses the i2s block for the audio codec
so if someone could test against that it would be much appreciated.

I'm also wondering if there is a preferred way of setting the lrclk
size in the dts?..currently it is set to the sample width but for example
the pcm5102a wants it to be 32 bits whatever the sample rate.

Thanks in advance,
CK

v2 changes compared to v1 are:
 - massive refactoring to remove duplicate code making use of regmap_fields.
 - extending the clock divisors.
 - removed code that should be delivered when we support 20/24bits

---

Marcus Cooper (2):
  ASoC: sun4i-i2s: Add more quirks for newer SoCs
  ASoC: sun4i-i2s: Add support for H3

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 469 ++++++++++++++++++---
 2 files changed, 407 insertions(+), 64 deletions(-)

-- 
2.13.3
