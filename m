From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Thu, 31 Jan 2013 18:23:03 +0530
Subject: [PATCH v4 0/3] ASoC davinci/tlv320aic3x updates, fixes & DT support
Message-ID: <1359636786-7056-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Convert tlv320aic3x mic bias to a supply widget and related machine driver
2. Add DT support for Davinci machine platform
3. Remove __dev* attributes

This patch-set is tested on Davinci platform (DA850 EVM). This series applies on
top of tag next-20130128 git tree
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

These patches cannot be tested directly on mainline kernel (DT based).
This is because dma is not yet completely ported to Davinci ASoC. I had to add
few hacks to get Audio working on Davinci DA850 platform.

For reference, I have placed the entire working tree @
Tree :  https://github.com/ghebbar/linux.git
Branch : dev_next-20130128_davinci_asoc_dt_v3

Changes in v4
	 - updated pending machine driver to change in micbias -> supply widget
	 - merge codec & machine driver change into a single commit

Changes in v3
	- drop mcasp pinctrl handler patch from series as it is now handled
	  centrally.
	- Convert tlv320aic3x mic bias to a supply widget and related machine
	  driver
	- remove __dev* attributes

Changes in v2
	 - Remove reference to Linux & software details from DT binding

Hebbar Gururaja (2):
  ASoC: tlv320aic3x: Convert mic bias to a supply widget
  ASoC: davinci: remove __dev* attributes

Hebbar, Gururaja (1):
  ASoC: davinci: machine: Add device tree binding

 .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    6 +
 include/sound/tlv320aic3x.h                        |   10 ++
 sound/soc/codecs/tlv320aic3x.c                     |   83 ++++++++-
 sound/soc/codecs/tlv320aic3x.h                     |    4 +
 sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
 sound/soc/omap/n810.c                              |    4 +-
 sound/soc/omap/rx51.c                              |    8 +-
 8 files changed, 318 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
