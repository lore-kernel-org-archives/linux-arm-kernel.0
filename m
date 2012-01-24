From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 24 Jan 2012 13:52:17 +0200
Subject: [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for PandaBoard family
Message-ID: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following series will add ASoC support for PandaBoards.
PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
the differences not that big to justify a new ASoC machine driver.

The v3 series did not made it to 3.3 kernel.
This set contains all the patches needed to enable the audio support on the
PandaBoard family.
The machine driver has been converted to a generic OMAP4 driver which can
support wide range of machines using OMAP4 with twl6040 codec.

I have remove the hardcoded MCLK clock frequency use in the machine driver
(there can be devices with different MCLK configuration). This changed
patch 04, 05, and 12. Since this does not affect the functionality I kept the
acks for these patches. Patch 11 did not existed in the v3 series.

Regards,
Peter
---
Peter Ujfalusi (13):
  ASoC: sdp4430: Correct author e-mail address
  ASoC: OMAP4: Rename the sdp4430 machine driver
  ASoC: omap-abe-twl6040: Correct internal prefix, Kconfig entry
  include: platform_data: Platform data header for OMAP4 ASoC audio
  OMAP4: 4430sdp: Register platform device for OMAP4 audio
  ASoC: omap-abe-twl6040: Convert to platform deriver
  ASoC: twl6040: Convert MICBIAS to SUPPLY widget
  ASoC: omap-abe-twl6040: Add complete DAPM routing
  ASoC: omap-abe-twl6040: DAI link selection based on platform data
  ASoC: omap-abe-twl6040: Configure card according to platform data
  ASoC: omap-abe-twl6040: Use provided MCLK frequency from pdata
  OMAP4: omap4panda: Enable audio support
  ASoC: Kconfig: OMAP4: Enable support for PandaBoards

 arch/arm/mach-omap2/board-4430sdp.c            |   29 ++
 arch/arm/mach-omap2/board-omap4panda.c         |   60 ++++-
 include/linux/platform_data/omap-abe-twl6040.h |   49 ++++
 sound/soc/codecs/twl6040.c                     |   16 +-
 sound/soc/omap/Kconfig                         |   13 +-
 sound/soc/omap/Makefile                        |    4 +-
 sound/soc/omap/omap-abe-twl6040.c              |  349 ++++++++++++++++++++++++
 sound/soc/omap/sdp4430.c                       |  279 -------------------
 8 files changed, 504 insertions(+), 295 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h
 create mode 100644 sound/soc/omap/omap-abe-twl6040.c
 delete mode 100644 sound/soc/omap/sdp4430.c

-- 
1.7.8.3
