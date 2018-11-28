From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Nov 2018 11:10:41 +0000
Subject: [PATCH 0/8] SA11xx PCMCIA updates and GPIOD conversion
Message-ID: <20181128111041.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a generic MAX1600 library which uses the GPIOD
interfaces to control the PCMCIA power switches, and converts
some SA11x0/PXA drivers to it, reducing the code duplication.
This also allows us to kill the SA1111 private GPIO interfaces.

 arch/arm/common/sa1111.c                   |  59 --------------
 arch/arm/include/asm/hardware/sa1111.h     |   4 -
 arch/arm/mach-pxa/Kconfig                  |   1 +
 arch/arm/mach-pxa/include/mach/mainstone.h |   4 +
 arch/arm/mach-pxa/lubbock.c                |  16 ++++
 arch/arm/mach-pxa/mainstone.c              |  53 +++++++++++++
 arch/arm/mach-sa1100/generic.c             |  10 ---
 arch/arm/mach-sa1100/h3100.c               |   1 +
 arch/arm/mach-sa1100/jornada720.c          |  12 +++
 arch/arm/mach-sa1100/neponset.c            |  19 +++++
 drivers/pcmcia/Kconfig                     |   6 ++
 drivers/pcmcia/Makefile                    |   1 +
 drivers/pcmcia/max1600.c                   | 122 +++++++++++++++++++++++++++++
 drivers/pcmcia/max1600.h                   |  32 ++++++++
 drivers/pcmcia/pxa2xx_mainstone.c          | 113 ++++++++------------------
 drivers/pcmcia/sa1100_simpad.c             |   4 +-
 drivers/pcmcia/sa1111_jornada720.c         |  83 +++++++++++++-------
 drivers/pcmcia/sa1111_lubbock.c            | 110 +++++---------------------
 drivers/pcmcia/sa1111_neponset.c           |  79 +++++--------------
 19 files changed, 396 insertions(+), 333 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
