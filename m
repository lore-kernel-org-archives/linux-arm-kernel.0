From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 12 Mar 2018 16:57:47 +0100
Subject: [PATCH v2 0/6] ASoC: sun4i-i2s: Updates to the driver
Message-ID: <20180312155753.9478-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. The original attempt had some changes related to the slave work
but I've left them out for this release as I would still like to do some
more investigations.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and loopback so block testing can be made without an external codec.

I've also moved away from using tdm to set the slot width and now use
a dedicated property.

This has been tested on a Pine64 using the ES9023 audio POT board
(https://github.com/codekipper/linux-sunxi/commits/upstream)
and HDMI audio
(https://github.com/codekipper/linux-sunxi/commits/sunxi-wip-a64)

BR,
CK

---
v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (6):
  ASoC: sun4i-i2s: Add slot width override
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Correct divider calculations
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Add support for loopback

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  11 ++
 sound/soc/sunxi/sun4i-i2s.c                        | 199 ++++++++++++++++-----
 2 files changed, 170 insertions(+), 40 deletions(-)

-- 
2.16.2
