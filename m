From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 31 Aug 2012 18:20:56 +0530
Subject: [PATCH 0/3] ASoC: Davinci: McASP: add support new McASP IP Variant
Message-ID: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
register offset and missing generic SRAM APIs support

Changes
- Add new MCASP_VERSION_3 to identify new variant. New DT compatible
  "ti,omap2-mcasp-audio" to identify version 3 controller.
- The register offsets are handled depending on the version.
- Provide a config option to indicate missing SRAM API support.

While here, fix a typo caused by recent commit (cf53756 - ASoC: davinci: 
davinci-pcm does not need to be a plaform_driver)

Note:
   DMA parameters (dma fifo offset) are not updated and will be done later.

Hebbar, Gururaja (3):
  ASoC: Davinci: McASP: add support new McASP IP Variant
  ASoC: Davinci: pcm: add support for sram-support-less platforms
  ASoC: Davinci: evm: Fix typo in cpu dai name

 .../bindings/sound/davinci-mcasp-audio.txt         |    1 +
 include/linux/platform_data/davinci_asp.h          |    1 +
 sound/soc/davinci/Kconfig                          |    5 ++
 sound/soc/davinci/davinci-evm.c                    |    2 +-
 sound/soc/davinci/davinci-mcasp.c                  |   71 ++++++++++++++++----
 sound/soc/davinci/davinci-pcm.c                    |    8 ++
 6 files changed, 74 insertions(+), 14 deletions(-)
