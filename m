From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Sep 2014 16:54:08 -0700
Subject: [GIT PULL] ARM: brcmstb: SMP, earlyprintk and Kconfig cleanups
Message-ID: <1411689248-14074-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This pull request contains 3 changes for the brcmstb platform

- first patch re-introduces SMP support after fixing the problems we had in
  the initial implementation, for this patch to apply cleanly, I had to advance
  up to "ARM: brcmstb: revert SMP support"

- second patch is dropping unused Kconfig dependencies

- third patch adds earlyprintk to brcmstb platforms using the existing 8250
  infrastructure

Thanks!

The following changes since commit fc3e825fa91636a5d1b992e769b2d8279877bfad:

  ARM: brcmstb: revert SMP support (2014-08-25 18:46:31 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/brcmstb-smp-uart-for-3.18

for you to fetch changes up to 1a7539e692f8649246d1394fd60275fa36b6820c:

  ARM: brcmstb: Kconfig: drop unneeded symbol selections (2014-09-25 16:50:27 -0700)

----------------------------------------------------------------
Brian Norris (2):
      ARM: brcmstb: reintroduce SMP support
      ARM: brcmstb: Kconfig: drop unneeded symbol selections

Marc Carino (1):
      ARM: brcmstb: add debug UART for earlyprintk support

 arch/arm/Kconfig.debug              |  16 +-
 arch/arm/mach-bcm/Kconfig           |   3 -
 arch/arm/mach-bcm/Makefile          |   2 +
 arch/arm/mach-bcm/brcmstb.h         |  19 +++
 arch/arm/mach-bcm/headsmp-brcmstb.S |  33 ++++
 arch/arm/mach-bcm/platsmp-brcmstb.c | 329 ++++++++++++++++++++++++++++++++++++
 6 files changed, 398 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-bcm/brcmstb.h
 create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 create mode 100644 arch/arm/mach-bcm/platsmp-brcmstb.c
