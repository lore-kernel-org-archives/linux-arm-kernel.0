From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Feb 2016 10:07:38 +0100
Subject: [GIT PULL] Versatile family DT cleanups step 1
Message-ID: <CACRpkdYR-_41Ay7b_X4hJkPY7dUR2qAsfsjn-MzpahVWqEiVPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is a first pull request for my cleanups for the Versatile, as the
finished stuff should not be sitting in my tree but in ARM SoC.
This completes the ARM RealView PB1176 and PB11MPCore
device trees, and moves the Versatile to use power/reset.

The idea is to keep working on this cleanup branch and send
additional patches on top of this one as the prerequisites are
merged into the MTD and FBDEV subsystems. So please create
a special versatile cleanup branch (or suggest another approach).

As it happens, board files and device trees need to change at the
same time to make logical sense, especially for Versatile where
auxdata is replaced with DT entries, such as when reset is moved
in the last patch in this set. The MTD and CLCD changes will share
this characteristic.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-dt-cleanup-1

for you to fetch changes up to 1c6e288da6cc3c72579ff0062b5a5684fb9ef90e:

  ARM: versatile: move restart to the device tree (2016-02-15 09:58:08 +0100)

----------------------------------------------------------------
Versatile family cleanups step 1:
- Finalize RealView the PB1176 and PB11MPCore device trees
- Move Versatile to use the power/reset driver instead of a
  custom restart hook

----------------------------------------------------------------
Linus Walleij (8):
      ARM: realview: add flash devices to the PB1176 DTS
      ARM: realview: fix up PB11MP flash compat strings
      ARM: pb1176: add ICST307 clocks to the device tree
      ARM: pb1176: add AACI to the device tree
      ARM: pb1176: add ISP1761 USB OTG host controller
      ARM: pb1176: add ethernet to devicetree
      ARM: realview: add the DS1338 RTC to PB1176 DT
      ARM: versatile: move restart to the device tree

 arch/arm/boot/dts/arm-realview-pb1176.dts | 118 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/arm-realview-pb11mp.dts |   4 +-
 arch/arm/mach-versatile/Kconfig           |   3 +
 arch/arm/mach-versatile/versatile_dt.c    |  15 ----
 4 files changed, 123 insertions(+), 17 deletions(-)
