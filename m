From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 23:00:40 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180715060040.ni7w7mierlxk3wrv@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit f0463f3619fd10e0cbaa5195bf2bc264a77a586d:

  Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-05 14:59:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 13e66ceea1600f1061181acc2d4e0fac1a7d0333:

  Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-14 15:14:02 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

 - A fix for OMAP5 and DRA7 to make the branch predictor hardening
   settings take proper effect on secondary cores
 - Disable USB OTG on am3517 since current driver isn't working
 - Fix thermal sensor register settings on Armada 38x
 - Fix suspend/resume IRQs on pxa3xx

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller

Baruch Siach (1):
      ARM: dts: armada-38x: use the new thermal binding

Daniel Mack (1):
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores

Olof Johansson (3):
      Merge tag 'pxa-fixes-4.18' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'mvebu-fixes-4.18-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

 arch/arm/boot/dts/am3517.dtsi     |  5 +++++
 arch/arm/boot/dts/armada-38x.dtsi |  2 +-
 arch/arm/mach-omap2/omap-smp.c    | 41 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/irq.c           |  4 ++--
 4 files changed, 49 insertions(+), 3 deletions(-)
