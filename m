From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Jan 2017 10:05:14 -0800
Subject: [GIT PULL 1/5] non-urgent omap fixes for v4.11 merge window
Message-ID: <pull-1485274191-192300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-not-urgent-signed

for you to fetch changes up to 631af44c10f9430163296626c6134db16a4f51fb:

  ARM: OMAP3: Fix SoC detection of OMAP36/37 Family (2017-01-20 10:13:06 -0800)

----------------------------------------------------------------
Non-urgent fixes for omaps for v4.11 merge window. These all are
fixes for things that have never worked or have been broken for
a long time and nobody noticed:

- Fix omap3 off mode pull defines

- Allow multiple pdata quirks instead of just one

- Fix am335x and dm814x scm syscon to probe children too

- Fix compatible for ti81xx to allow use with 8250_omap as well

- Fix 8250_omap on omap5 by adding HWMOD_SWSUP_SIDLE_ACT flag

- Fix SoC detection for omap36/37 SoCs

----------------------------------------------------------------
Adam Ford (1):
      ARM: OMAP3: Fix SoC detection of OMAP36/37 Family

Tony Lindgren (4):
      ARM: dts: Fix omap3 off mode pull defines
      ARM: OMAP2+: Fix init for multiple quirks for the same SoC
      ARM: dts: Fix am335x and dm814x scm syscon to probe children
      ARM: dts: Fix compatible for ti81xx uarts for 8250

Vignesh R (1):
      ARM: OMAP5: Add HWMOD_SWSUP_SIDLE_ACT flag for UART

 arch/arm/boot/dts/am33xx.dtsi              |  3 ++-
 arch/arm/boot/dts/dm814x.dtsi              |  9 +++++----
 arch/arm/boot/dts/dm816x.dtsi              |  6 +++---
 arch/arm/mach-omap2/id.c                   | 10 +++++++++-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  8 ++++++--
 arch/arm/mach-omap2/pdata-quirks.c         |  1 -
 include/dt-bindings/pinctrl/omap.h         |  4 ++--
 7 files changed, 27 insertions(+), 14 deletions(-)
