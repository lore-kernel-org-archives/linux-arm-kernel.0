From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 12 Sep 2015 15:26:22 +0200
Subject: [PATCH 0/2] ASoC: Add support for the Allwinner A10 codec
Message-ID: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch set adds the support for what Allwinner calls the codec on
their SoCs.

This codec is actually a combination of a codec and DAI, tied together
in a single memory-mapped IP. It is completely standalone, and outputs
directly the analog signal.

While it supports both playback and capture, the capture is not
implemented in this patch, and will be posted eventually as a separate
one.

This set, in order to be functional, has a dependency on the audio
clocks patch set posted separately. However, it doesn't needs this to
compile properly, so I guess it can be merged without really caring
for the merging status of the clock patches.

Let me know what you think,
Maxime

Emilio L?pez (1):
  ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs

Maxime Ripard (1):
  Documentation: bindings: Add the Allwinner A10 codec bindings

 .../devicetree/bindings/sound/sun4i-codec.txt      |  33 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/sunxi/Kconfig                            |  11 +
 sound/soc/sunxi/Makefile                           |   2 +
 sound/soc/sunxi/sun4i-codec.c                      | 720 +++++++++++++++++++++
 6 files changed, 767 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt
 create mode 100644 sound/soc/sunxi/Kconfig
 create mode 100644 sound/soc/sunxi/Makefile
 create mode 100644 sound/soc/sunxi/sun4i-codec.c

-- 
2.5.1
