From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Mar 2013 14:30:13 +0100
Subject: [GIT PULL] at91: cleanup + soc for 3.10 #1
Message-ID: <51432265.2060905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is a pull-request targeted to do some cleanup in AT91 Kconfig
and board-dt-xxx.c files. It will prepare the coming introduction of
our SAMA5D3 family (Atmel new Cortex-A5) that we will stack on top
of these modifications soon.

Thanks, best regards,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-soc

for you to fetch changes up to 9317960fa38ff50ac287904e4c751a169635ecbf:

  ARM: at91: renamme rm9200 dt file (2013-03-13 17:28:14 +0100)

----------------------------------------------------------------
Simplification of Kconfig and splitting of the non-DT part.
Common pattern for DT board file naming.

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91: move non DT Kconfig to Kconfig.non_dt
      ARM: at91: rename board-dt to more specific name board-dt-sam9
      ARM: at91: renamme rm9200 dt file

 arch/arm/configs/at91_dt_defconfig                          |   2 +-
 arch/arm/configs/at91sam9260_defconfig                      |   2 +-
 arch/arm/configs/at91sam9g20_defconfig                      |   2 +-
 arch/arm/configs/at91sam9g45_defconfig                      |   2 +-
 arch/arm/mach-at91/Kconfig                                  | 398 +---------------------------------
 arch/arm/mach-at91/Kconfig.non_dt                           | 399 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile                                 |   4 +-
 arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} |   0
 arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c}          |   0
 9 files changed, 407 insertions(+), 402 deletions(-)
 create mode 100644 arch/arm/mach-at91/Kconfig.non_dt
 rename arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} (100%)
 rename arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c} (100%)

-- 
Nicolas Ferre
