From: csd@broadcom.com (Christian Daudt)
Date: Tue, 20 Aug 2013 11:33:51 -0700
Subject: [GIT PULL] ARM: bcm SOC  for 3.12
Message-ID: <5213B68F.4050800@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,
  Please pull the branch below. It contains various SOC related cleanups 
for BCM arch.

  Thanks,
    csd

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

   git://github.com/broadcom/bcm11351.git armsoc/for-3.12/soc

for you to fetch changes up to 3a76b35186cb967a69c4a3935caf2fdf428e933b:

   ARM: bcm: Make secure API call optional (2013-08-20 10:51:39 -0700)

----------------------------------------------------------------
SoC changes for 3.12 BCM

----------------------------------------------------------------
Christian Daudt (4):
       ARM: bcm: Rename board_bcm
       ARM: mmc: fix NONREMOVABLE test in sdhci-bcm-kona
       ARM: DT: binding fixup to align with vendor-prefixes.txt (drivers)
       ARM: bcm: Make secure API call optional

Markus Mayer (4):
       ARM: bcm281xx: Turn on L2 cache.
       ARM bcm281xx: Turn on socket & network support.
       ARM: bcm281xx: Board specific reboot code
       mmc: sdhci-bcm-kona: make linker-section warning go away

Matt Porter (1):
       ARM: configs: disable DEBUG_LL in bcm_defconfig

  arch/arm/configs/bcm_defconfig                      |   13 ++++++++++++-
  arch/arm/mach-bcm/Kconfig                           |    1 +
  arch/arm/mach-bcm/Makefile                          |    4 ++--
  arch/arm/mach-bcm/bcm_kona_smc.c                    |   12 ++++++++----
  arch/arm/mach-bcm/bcm_kona_smc.h                    |    2 +-
  arch/arm/mach-bcm/{board_bcm.c => board_bcm281xx.c} |   30 
+++++++++++++++++++++++-------
  arch/arm/mach-bcm/kona.c                            |   65 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/arm/mach-bcm/kona.h                            |   17 
+++++++++++++++++
  drivers/clocksource/bcm_kona_timer.c                |    8 +++++++-
  drivers/mmc/host/sdhci-bcm-kona.c                   |   15 ++++++++-------
  10 files changed, 144 insertions(+), 23 deletions(-)
  rename arch/arm/mach-bcm/{board_bcm.c => board_bcm281xx.c} (68%)
  create mode 100644 arch/arm/mach-bcm/kona.c
  create mode 100644 arch/arm/mach-bcm/kona.h
