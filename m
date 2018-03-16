From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Mar 2018 19:55:52 +0000
Subject: [PATCH 0/8] sa1100: Generic CF socket support
Message-ID: <20180316195552.GS9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds generic soc-common based CF socket support, which
in conjunction with using gpiolib and regulator, allows us to
eliminate a bunch of SA11x0 specific low-level socket drivers.
This series covers just SA11x0 drivers.

 arch/arm/mach-sa1100/Kconfig                |   4 +
 arch/arm/mach-sa1100/assabet.c              |  39 +++++++-
 arch/arm/mach-sa1100/cerf.c                 |  18 +++-
 arch/arm/mach-sa1100/clock.c                |   2 +
 arch/arm/mach-sa1100/generic.c              |  44 ++++++++-
 arch/arm/mach-sa1100/generic.h              |   8 ++
 arch/arm/mach-sa1100/h3xxx.c                |  17 ++++
 arch/arm/mach-sa1100/include/mach/assabet.h |   6 --
 arch/arm/mach-sa1100/nanoengine.c           |  23 +++++
 arch/arm/mach-sa1100/shannon.c              |  38 ++++++++
 arch/arm/mach-sa1100/simpad.c               |  11 +++
 drivers/pcmcia/Makefile                     |   3 -
 drivers/pcmcia/sa1100_assabet.c             | 100 ---------------------
 drivers/pcmcia/sa1100_cerf.c                |  86 ------------------
 drivers/pcmcia/sa1100_generic.c             | 115 ++++++++++++++++++++----
 drivers/pcmcia/sa1100_generic.h             |   4 -
 drivers/pcmcia/sa1100_h3600.c               |  16 ++--
 drivers/pcmcia/sa1100_nanoengine.c          | 133 ----------------------------
 drivers/pcmcia/sa1100_shannon.c             | 104 ----------------------
 drivers/pcmcia/sa1100_simpad.c              |  12 +--
 20 files changed, 307 insertions(+), 476 deletions(-)
 delete mode 100644 drivers/pcmcia/sa1100_assabet.c
 delete mode 100644 drivers/pcmcia/sa1100_cerf.c
 delete mode 100644 drivers/pcmcia/sa1100_nanoengine.c
 delete mode 100644 drivers/pcmcia/sa1100_shannon.c

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
