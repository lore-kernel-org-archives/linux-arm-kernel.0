From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  1 Jul 2013 10:39:25 +0200
Subject: [RFC PATCH 00/13] audio support for at91sam9x5ek board
Message-ID: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is some work I've done to make the sound work on sam9x5ek.
It's based on Nicolas Ferre's and Uwe Kleine-K?nig's work.
(Atmel patch on 2.6.39 if I recall)

I'd like to have some advice, mainly on the 1st patch
 "misc: atmel_ssc: add device tree DMA support".
I do not clearly see what is the right way to add DMA DT support for
this device, since it doesn't request a channel directly.


patches applies on next-20130701

[I let the original signed-off from Nicolas and Uwe in place, I don't
know if I should replace them by something like "originaly-signed-off-by"
since the code has been changed.]

Best regards,
Richard.


Nicolas Ferre (3):
  sound: sam9x5_wm8731: machine driver for at91sam9x5 wm8731 boards
  sound: atmel_ssc_dai: PM: actually stopping clock on suspend/resume
  sound: wm8731: rework power management

Richard Genoud (10):
  misc: atmel_ssc: add device tree DMA support
  misc: atmel_ssc: keep the count of pdev->id
  ARM: at91: DTS: sam9x5: add clock for SSC DT entry
  ARM: at91: DTS: sam9x5: add SSC DMA parameters
  ARM: AT91: DTS: sam9x5ek: add WM8731 codec
  ARM: AT91: DTS: sam9x5ek: add sound configuration
  ARM: AT91: DTS: sam9x5ek: enable SSC
  sound: atmel-pcm: don't return ok if pcm-dma is not implemented
  sound: atmel-pcm-dma: check pointer before dereference
  sound: codec: wm8371: correct capture line/mic

 arch/arm/boot/dts/at91sam9x5.dtsi       |    3 +
 arch/arm/boot/dts/at91sam9x5ek.dtsi     |   27 ++++
 arch/arm/mach-at91/at91sam9x5.c         |    1 +
 drivers/misc/atmel-ssc.c                |   63 +++++++++
 include/linux/atmel-ssc.h               |    2 +
 include/linux/platform_data/dma-atmel.h |    2 +
 sound/soc/atmel/Kconfig                 |   12 ++
 sound/soc/atmel/Makefile                |    2 +
 sound/soc/atmel/atmel-pcm-dma.c         |    3 +
 sound/soc/atmel/atmel-pcm.h             |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c         |   20 ++-
 sound/soc/atmel/sam9x5_wm8731.c         |  232 +++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8731.c               |   10 +-
 13 files changed, 368 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/atmel/sam9x5_wm8731.c

-- 
1.7.10.4
