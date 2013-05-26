From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 May 2013 22:32:45 +0200
Subject: [GIT PULL] Nomadik clocks from device tree
In-Reply-To: <CACRpkdY8xqi04cf-SJ69QvHr8qB6itqvgxMyNk+=Xrtz2FGVaA@mail.gmail.com>
References: <CACRpkdY8xqi04cf-SJ69QvHr8qB6itqvgxMyNk+=Xrtz2FGVaA@mail.gmail.com>
Message-ID: <CACRpkdaKtxKS0=1UOKJPQWKShRm2nHsUWSK5M+qSR6duXfGrxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

I have accumulated more Nomadik patches so I'm reiterating this
pull request with two new patches on top.

Please pull them in for v3.11!

Yours,
Linus Walleij


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-dt-for-arm-soc

for you to fetch changes up to 49932f5ef13fa6a5a8bd71cf2f0b721d0e0b495d:

  ARM: nomadik: move the pin configuration to DT (2013-05-26 22:25:36 +0200)

----------------------------------------------------------------
Device tree patches for the Nomadik machine:
- Move clock registration to the device tree
- Support probing the MTU timer from the device tree
- Register user LED and user key in the device tree
- Update defconfig to account for user LED and user key
- Move pin control mappings to the device tree

----------------------------------------------------------------
Linus Walleij (4):
      ARM: nomadik: convert all clocks except timer to dt
      ARM: nomadik: register clocksource from device tree
      ARM: nomadik: add led and key for S8815
      ARM: nomadik: move the pin configuration to DT

Rabin Vincent (1):
      clocksource: nomadik-mtu: support of probe

 .../devicetree/bindings/arm/ste-nomadik.txt        |   5 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  63 +++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 145 ++++++++++++++++++++-
 arch/arm/configs/nhk8815_defconfig                 |   6 +
 arch/arm/mach-nomadik/Kconfig                      |   1 +
 arch/arm/mach-nomadik/cpu-8815.c                   |  73 +----------
 drivers/clk/clk-nomadik.c                          |  41 +-----
 drivers/clocksource/nomadik-mtu.c                  |  70 ++++++++--
 8 files changed, 288 insertions(+), 116 deletions(-)
