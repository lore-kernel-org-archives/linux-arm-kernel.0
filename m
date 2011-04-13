From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 13 Apr 2011 10:20:49 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.39-rc3
Message-ID: <BANLkTimtAPkV6p_hxiaUC_Ze6BEiXnRrSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please consider pull:

The following changes since commit a6360dd37e1a144ed11e6548371bade559a1e4df:

  Linux 2.6.39-rc3 (2011-04-11 17:21:51 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Dmitry Eremin-Solenikov (2):
      pcmcia: limit pxa2xx_balloon3 subdriver to balloon3 platform
      pcmcia: limit pxa2xx_trizeps4 subdriver to trizeps4 platform

Eric Miao (1):
      ARM: pxa: convert incorrect IRQ_TO_IRQ() to irq_to_gpio()

Haojian Zhuang (3):
      ARM: pxa: always clear LPM bits for PXA168 MFPR
      ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt number
      ARM: mmp: align NR_BUILTIN_GPIO with gpio interrupt number

Marek Vasut (1):
      ARM: pxafb: Fix access to nonexistent member of pxafb_info

 arch/arm/mach-mmp/include/mach/gpio.h       |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |    9 +++++++++
 arch/arm/mach-pxa/include/mach/gpio.h       |   17 +++++++++++++++--
 arch/arm/mach-pxa/include/mach/irqs.h       |    3 ---
 arch/arm/mach-pxa/pxa25x.c                  |    2 +-
 arch/arm/mach-pxa/pxa27x.c                  |    2 +-
 drivers/pcmcia/pxa2xx_balloon3.c            |    5 +++++
 drivers/pcmcia/pxa2xx_trizeps4.c            |   15 +++++++++------
 drivers/video/pxafb.c                       |    4 +++-
 9 files changed, 44 insertions(+), 15 deletions(-)
