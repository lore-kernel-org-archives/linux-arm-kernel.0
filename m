From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Jul 2014 10:44:18 -0400
Subject: [GIT PULL] ARM: mach-bcm: soc updates for 3.17
Message-ID: <20140728144418.GA8885@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following mach-bcm soc updates for 3.17.

-Matt

The following changes since commit 9a3c4145af32125c5ee39c0272662b47307a8323:

  Linux 3.16-rc6 (2014-07-20 21:04:16 -0700)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/for-3.17/bcm-soc

for you to fetch changes up to 2df94fd66a1135f887bfabef413b568969f5d77b:

  MAINTAINERS: add entry for Broadcom ARM STB architecture (2014-07-28 09:59:59 -0400)

----------------------------------------------------------------
ARM: mach-bcm: soc updates for 3.17

- BCM Mobile SMP support
- BRCM STB platform support

----------------------------------------------------------------
Alex Elder (2):
      ARM: add SMP support for Broadcom mobile SoCs
      ARM: configs: enable SMP in bcm_defconfig

Brian Norris (2):
      ARM: brcmstb: select GISB arbiter and interrupt drivers
      MAINTAINERS: add entry for Broadcom ARM STB architecture

Marc Carino (1):
      ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs

 MAINTAINERS                         |   8 +
 arch/arm/configs/bcm_defconfig      |   1 +
 arch/arm/configs/multi_v7_defconfig |   1 +
 arch/arm/mach-bcm/Kconfig           |  34 +++-
 arch/arm/mach-bcm/Makefile          |   8 +
 arch/arm/mach-bcm/brcmstb.c         |  28 +++
 arch/arm/mach-bcm/brcmstb.h         |  19 ++
 arch/arm/mach-bcm/headsmp-brcmstb.S |  33 ++++
 arch/arm/mach-bcm/kona_smp.c        | 202 ++++++++++++++++++++
 arch/arm/mach-bcm/platsmp-brcmstb.c | 363 ++++++++++++++++++++++++++++++++++++
 10 files changed, 694 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-bcm/brcmstb.c
 create mode 100644 arch/arm/mach-bcm/brcmstb.h
 create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 create mode 100644 arch/arm/mach-bcm/kona_smp.c
 create mode 100644 arch/arm/mach-bcm/platsmp-brcmstb.c
