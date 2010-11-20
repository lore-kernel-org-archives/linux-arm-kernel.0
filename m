From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sat, 20 Nov 2010 15:59:21 +0300
Subject: [PATCH 0/3] ASoC: add support for audio on iPaq hx4700
Message-ID: <1290257964-17435-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's three patches adding support for audio on iPaq hx4700 PDA.
AK4641 codec driver was originally written by Harald Welte for 
gnufiish project [1], then Philipp Zabel adapted it to use on hx4700.
I picked Philipp's patches from his git repository[2], updated them to
current kernel and also fixed all the issues I've met while
using these patches on my hx4700 device. So now I would like to submit
these patches for review in hope they could be included in 2.6.38.

This patchset is based on linux-next-20101119

[1] http://gnufiish.org
[2] http://git.linuxtogo.org/?p=ph5/kernel.git;a=summary


Dmitry Artamonow (2):
  ASoC: Asahi Kasei AK4641 codec driver
  ASoC: add iPAQ hx4700 machine driver

Philipp Zabel (1):
  pxa/hx4700: add I2C board info for AK4641 codec

 arch/arm/mach-pxa/hx4700.c              |   18 +
 arch/arm/mach-pxa/include/mach/hx4700.h |    4 +-
 include/sound/ak4641.h                  |   26 ++
 sound/soc/codecs/Kconfig                |    4 +
 sound/soc/codecs/Makefile               |    2 +
 sound/soc/codecs/ak4641.c               |  628 +++++++++++++++++++++++++++++++
 sound/soc/codecs/ak4641.h               |   47 +++
 sound/soc/pxa/Kconfig                   |    9 +
 sound/soc/pxa/Makefile                  |    2 +
 sound/soc/pxa/hx4700.c                  |  253 +++++++++++++
 10 files changed, 991 insertions(+), 2 deletions(-)
 create mode 100644 include/sound/ak4641.h
 create mode 100644 sound/soc/codecs/ak4641.c
 create mode 100644 sound/soc/codecs/ak4641.h
 create mode 100644 sound/soc/pxa/hx4700.c
