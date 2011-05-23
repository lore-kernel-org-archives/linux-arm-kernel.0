From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 23 May 2011 09:50:15 -0600
Subject: [git pull] ARM Device tree support
Message-ID: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

How do you want to handle merging the ARM DT support?  Do you want to
pull it into your tree, or would you like me to ask Linus to pull
directly?  As you can see, It does include a couple of pre-requisite
cross-arch cleanups that I normally push to Linus directly.

The following changes since commit 61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf:

  Linux 2.6.39 (2011-05-18 21:06:34 -0700)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 devicetree/arm-next

Andres Salomon (1):
      of/flattree: minor cleanups

Grant Likely (6):
      dt/flattree: explicitly pass command line pointer to
early_init_dt_scan_chosen
      arm/dt: Make __vet_atags also accept a dtb image
      arm/dt: Allow CONFIG_OF on ARM
      arm/dt: consolidate atags setup into setup_machine_atags
      arm/dt: probe for platforms via the device tree
      dt: add documentation of ARM dt boot interface

 Documentation/arm/Booting                       |   33 +++++-
 Documentation/devicetree/booting-without-of.txt |   48 +++++++-
 arch/arm/Kconfig                                |    7 +
 arch/arm/include/asm/mach/arch.h                |    9 ++
 arch/arm/include/asm/prom.h                     |   37 ++++++
 arch/arm/include/asm/setup.h                    |    4 +
 arch/arm/kernel/Makefile                        |    1 +
 arch/arm/kernel/devtree.c                       |  145 +++++++++++++++++++++++
 arch/arm/kernel/head-common.S                   |   24 +++-
 arch/arm/kernel/head.S                          |    8 +-
 arch/arm/kernel/setup.c                         |   90 +++++++++-----
 arch/arm/mm/init.c                              |   11 ++
 arch/microblaze/kernel/prom.c                   |    2 +-
 arch/mips/include/asm/prom.h                    |    3 -
 arch/mips/kernel/prom.c                         |    3 +-
 arch/powerpc/kernel/prom.c                      |    2 +-
 drivers/of/fdt.c                                |    8 +-
 17 files changed, 375 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/include/asm/prom.h
 create mode 100644 arch/arm/kernel/devtree.c
