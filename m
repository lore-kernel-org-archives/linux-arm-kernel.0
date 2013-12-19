From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Dec 2013 15:54:57 +0000
Subject: [PATCH 00/10] ASoC: ARM: ux500: Better prepare for full Device Tree
Message-ID: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At this moment in time the Ux500 ASoC driver obtains its DMA information
via AUXDATA platform data passing. To make the driver more independent
we have to start extracting it from the Device Tree. This patch-set goes
some way to ensure the ux500 Audio driver is ready for the switch over.

 arch/arm/mach-ux500/board-mop500-audio.c     |   8 +++----
 include/linux/platform_data/asoc-ux500-msp.h |   9 +-------
 sound/soc/codecs/ab8500-codec.c              |   4 ++--
 sound/soc/ux500/mop500.c                     |   2 ++
 sound/soc/ux500/ux500_msp_dai.c              | 146 +++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
 sound/soc/ux500/ux500_msp_i2s.c              |  56 ++++++++++++++++++++++++++++++++------------
 sound/soc/ux500/ux500_msp_i2s.h              |   2 +-
 sound/soc/ux500/ux500_pcm.c                  |  50 ++++++++++++++++++++++++++--------------
 8 files changed, 144 insertions(+), 133 deletions(-)
