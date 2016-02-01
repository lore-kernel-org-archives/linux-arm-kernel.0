From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  1 Feb 2016 21:35:54 +0100
Subject: [PATCH 0/4] ARM Davinci warning fixes
Message-ID: <1454358962-640598-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin and Sekhar,

Here are a couple of warning fixes for Davinci that I have
collected while testing randconfig kernels.

The first three are rather obvious, the last one might
need some discussion, maybe there is another way to do this.

Please apply for 4.6, or Ack

	Arnd

Arnd Bergmann (4):
  ARM: davinci: limit DT support to DA850
  ARM: davinci: avoid unused mityomapl138_pn_info variable
  ARM: davinci: DA8xx+DMx combined kernels need PATCH_PHYS_VIRT
  ARM: davinci: make I2C support optional

 arch/arm/Kconfig                           |  1 +
 arch/arm/mach-davinci/Kconfig              | 22 ++++------------------
 arch/arm/mach-davinci/board-dm644x-evm.c   |  8 ++++++--
 arch/arm/mach-davinci/board-dm646x-evm.c   |  7 +++++++
 arch/arm/mach-davinci/board-mityomapl138.c |  2 +-
 5 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.7.0
