From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 20 Oct 2014 14:26:48 -0700
Subject: [GIT PULL] ARM: brcmstb: SMP, Kconfig, earlyprintk and GISB fixes
Message-ID: <1413840408-14860-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes were posted late during the v3.18 release cycle, and were
eventually added to your 'late' branch, but here is an updated version

Thanks!

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/brcmstb-smp-uart-for-3.19

for you to fetch changes up to 203bb85ed605e43eadca62afb3a8cd128a8ec10a:

  bus: brcmstb_gisb: save and restore GISB timeout (2014-10-20 12:44:42 -0700)

----------------------------------------------------------------
This pull request contains 3 changes for the brcmstb platform and 2 changes
to the GISB bus arbiter driver

- fist patch adds earlyprintk to brcmstb platforms using the existing 8250
  infrastructure

- second patch re-introduces SMP support after fixing the problems we had in
  the initial implementation, for this patch to apply cleanly, I had to advance
  up to "ARM: brcmstb: revert SMP support"

- third patch is dropping unused Kconfig dependencies

- fourth patch registers the ARM fault code for external aborts that the GISB
  bus arbiter driver is designed to assit

- fifth patch does save/restore the GISB arbiter timeout across S3
  suspend/resume cycles

Thanks!

----------------------------------------------------------------
Brian Norris (2):
      ARM: brcmstb: reintroduce SMP support
      ARM: brcmstb: Kconfig: drop unneeded symbol selections

Florian Fainelli (2):
      bus: brcmstb_gisb: register the fault code hook
      bus: brcmstb_gisb: save and restore GISB timeout

Marc Carino (1):
      ARM: brcmstb: add debug UART for earlyprintk support

 arch/arm/Kconfig.debug              |  16 +-
 arch/arm/mach-bcm/Kconfig           |   3 -
 arch/arm/mach-bcm/Makefile          |   2 +
 arch/arm/mach-bcm/brcmstb.h         |  19 +++
 arch/arm/mach-bcm/headsmp-brcmstb.S |  33 ++++
 arch/arm/mach-bcm/platsmp-brcmstb.c | 329 ++++++++++++++++++++++++++++++++++++
 drivers/bus/brcmstb_gisb.c          |  45 ++++-
 7 files changed, 437 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-bcm/brcmstb.h
 create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 create mode 100644 arch/arm/mach-bcm/platsmp-brcmstb.c
