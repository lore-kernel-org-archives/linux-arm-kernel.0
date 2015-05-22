From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 May 2015 11:05:34 +0200
Subject: [GIT PULL] at91: cleanup for 4.2 #1
Message-ID: <20150522090534.GA499@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This is the final cleanup that didn't make it for 4.1. The mach-at91
folder now only contains core SoC and PM support.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-cleanup

for you to fetch changes up to 196b44ea0f7582290e84dbb37f10d2468f726fbf:

  ARM: at91: remove useless Makefile.boot (2015-05-20 16:38:00 +0200)

----------------------------------------------------------------
First batch of cleanup for 4.2:
 - use syscon in the ata and cf drivers to configure the SMC and drop
 sam9_smc.c
 - switch the at91rm9200 memory controller to syscon
 - remove last useless headers
 - remove now useless Makefile.boot

----------------------------------------------------------------
Alexandre Belloni (8):
      ata: at91: use syscon to configure the smc
      ARM: at91: drop sam9_smc.c
      ARM: at91: declare the at91rm9200 memory controller as a syscon
      pcmcia: at91_cf: Use syscon to configure the MC/smc
      ARM: at91/pm: use the atmel-mc syscon defines
      ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
      ARM: at91: remove at91rm9200_sdramc.h
      ARM: at91: remove useless Makefile.boot

Boris Brezillon (1):
      mfd: syscon: Add Atmel MC (Memory Controller) registers definition

 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                        |   5 -
 arch/arm/mach-at91/Makefile.boot                   |   8 --
 arch/arm/mach-at91/include/mach/at91_ramc.h        |  28 ----
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h    | 116 -----------------
 arch/arm/mach-at91/include/mach/at91sam9_smc.h     |  98 --------------
 arch/arm/mach-at91/pm.c                            |   8 +-
 arch/arm/mach-at91/pm.h                            |  14 +-
 arch/arm/mach-at91/pm_suspend.S                    |   3 +-
 arch/arm/mach-at91/sam9_smc.c                      | 136 -------------------
 arch/arm/mach-at91/sam9_smc.h                      |  11 --
 drivers/ata/Kconfig                                |   1 -
 drivers/ata/pata_at91.c                            |  92 ++++++++++---
 drivers/pcmcia/Kconfig                             |   1 -
 drivers/pcmcia/at91_cf.c                           |  25 ++--
 include/linux/mfd/syscon/atmel-mc.h                | 144 +++++++++++++++++++++
 include/soc/at91/at91rm9200_sdramc.h               |  63 ---------
 18 files changed, 249 insertions(+), 508 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
 delete mode 100644 arch/arm/mach-at91/sam9_smc.c
 delete mode 100644 arch/arm/mach-at91/sam9_smc.h
 create mode 100644 include/linux/mfd/syscon/atmel-mc.h
 delete mode 100644 include/soc/at91/at91rm9200_sdramc.h

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/1290719b/attachment.sig>
