From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 13 Dec 2009 21:17:14 +0800
Subject: [GIT PULL] pxa: for 2.6.33 - pcmcia fixes + em-x270 usb fix + zeus
	support
Message-ID: <f17812d70912130517v3d2ab1dfud8ff67770ba78f46@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
  Linus Torvalds (1):
        Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (2):
      pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops} to other modules
      pcmcia: fix now incorrect reference of skt->irq by using
skt->socket.pci_irq

Igor Grinberg (1):
      [ARM] pxa/em-x270: fix usb hub power up/reset sequence

Marc Zyngier (3):
      [ARM] pxa/zeus: basic support for Arcom Zeus SBC
      [ARM] pxa/zeus: make Viper pcmcia support more generic to support Zeus
      [ARM] pxa/zeus: default configuration for Arcom Zeus SBC.

 arch/arm/configs/zeus_defconfig               | 2032 +++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig                     |   14 +
 arch/arm/mach-pxa/Makefile                    |    1 +
 arch/arm/mach-pxa/em-x270.c                   |   11 +-
 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h |   11 +
 arch/arm/mach-pxa/include/mach/viper.h        |    2 -
 arch/arm/mach-pxa/include/mach/zeus.h         |   82 +
 arch/arm/mach-pxa/viper.c                     |   20 +-
 arch/arm/mach-pxa/zeus.c                      |  820 ++++++++++
 drivers/pcmcia/Kconfig                        |    2 +-
 drivers/pcmcia/Makefile                       |    2 +-
 drivers/pcmcia/pxa2xx_base.c                  |    5 +-
 drivers/pcmcia/pxa2xx_palmtc.c                |    2 +-
 drivers/pcmcia/pxa2xx_stargate2.c             |    2 +-
 drivers/pcmcia/pxa2xx_viper.c                 |  119 ++-
 15 files changed, 3077 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/configs/zeus_defconfig
 create mode 100644 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h
 create mode 100644 arch/arm/mach-pxa/include/mach/zeus.h
 create mode 100644 arch/arm/mach-pxa/zeus.c
