From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 15:25:12 +0200
Subject: [GIT PULL] Nomadik clocks from device tree
Message-ID: <CACRpkdY8xqi04cf-SJ69QvHr8qB6itqvgxMyNk+=Xrtz2FGVaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull this patch set for Nomadik clocks from the device
tree into ARM SoC for v3.11 at your convenience. All patches
are reviewed and drivers/clk changes are ACKed by the clk
maintainer.

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-clk-dt-for-arm-soc

for you to fetch changes up to 7690fbb293df83025cffb608f9c2e81414c468a8:

  ARM: nomadik: register clocksource from device tree (2013-05-12
21:49:56 +0200)

----------------------------------------------------------------
This patch set moves the Nomadik clock tree to the device
tree, and adds device tree support to the Nomadik MTU
timer.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: nomadik: convert all clocks except timer to dt
      ARM: nomadik: register clocksource from device tree

Rabin Vincent (1):
      clocksource: nomadik-mtu: support of probe

 .../devicetree/bindings/arm/ste-nomadik.txt        |  5 ++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 63 ++++++++++++++++++-
 arch/arm/mach-nomadik/Kconfig                      |  1 +
 arch/arm/mach-nomadik/cpu-8815.c                   | 26 ++------
 drivers/clk/clk-nomadik.c                          | 41 +++----------
 drivers/clocksource/nomadik-mtu.c                  | 70 ++++++++++++++++++----
 6 files changed, 137 insertions(+), 69 deletions(-)
