From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:39 +0800
Subject: [PATCH 0/6] footbridge consolidation patches 
Message-ID: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When trying to convert old leds event driver to led trigger drivers, I reviewed
the code of mach-footbridge. move seperated PCI code and leds code into a
single board files like other machines.

leds trigger code is based on Linus Walleij's driver in
arch/arm/plat-versatile/leds.c

Built successfully with footbridge_defconfig.

Bryan Wu (6):
  arm: footbridge: consolidation code of CATS machine
  arm: footbridge: consolidation code of EBSA285 machine
  arm: footbridge: consolidation code of Netwinder machine
  arm: footbridge: consolidation code of Compaq Personal Server
  arm: footbridge: convert old leds event driver to led gpio trigger
    driver of Netwinder
  arm: footbridge: convert old leds event driver to led trigger drivers
    of EBSA285

 arch/arm/mach-footbridge/Kconfig          |    6 +
 arch/arm/mach-footbridge/Makefile         |   15 +-
 arch/arm/mach-footbridge/cats-hw.c        |   95 ----
 arch/arm/mach-footbridge/cats-pci.c       |   58 ---
 arch/arm/mach-footbridge/cats.c           |  143 ++++++
 arch/arm/mach-footbridge/ebsa285-leds.c   |  139 ------
 arch/arm/mach-footbridge/ebsa285-pci.c    |   48 --
 arch/arm/mach-footbridge/ebsa285.c        |  114 +++++-
 arch/arm/mach-footbridge/netwinder-hw.c   |  660 --------------------------
 arch/arm/mach-footbridge/netwinder-leds.c |  139 ------
 arch/arm/mach-footbridge/netwinder-pci.c  |   62 ---
 arch/arm/mach-footbridge/netwinder.c      |  737 +++++++++++++++++++++++++++++
 arch/arm/mach-footbridge/personal-pci.c   |   56 ---
 arch/arm/mach-footbridge/personal.c       |   46 ++
 14 files changed, 1047 insertions(+), 1271 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/cats-hw.c
 delete mode 100644 arch/arm/mach-footbridge/cats-pci.c
 create mode 100644 arch/arm/mach-footbridge/cats.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-leds.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-pci.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-hw.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-leds.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-pci.c
 create mode 100644 arch/arm/mach-footbridge/netwinder.c
 delete mode 100644 arch/arm/mach-footbridge/personal-pci.c

-- 
1.7.5
