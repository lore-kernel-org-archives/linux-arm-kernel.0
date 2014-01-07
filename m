From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 16:18:05 +0100
Subject: [GIT PULL] ux500 devicetree fixups for v3.14
Message-ID: <CACRpkdbORJi0Hp8A_MzCENwAqLn65bLLMJHNUiySqsbDJNWg_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this fixes up and finalizes the stuff queued in linux-next for Ux500
devicetree migration/cleanups, most notably makes MMC/SD
cards work properly again.

Please pull in these 4 patches, they are based on top of what
is already in ARM SoC on the ux500/dt branch.

Yours,
Linus Walleij

The following changes since commit 089b5c9595eb3c516ab6af12802f16505cde271b:

  ARM: ux500: decomission custom SMP TWD timer init (2013-11-26 21:01:59 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-devicetree-v3.14-2

for you to fetch changes up to 0e7a268a9e2d85d36f146f9dcf1f54488111f3d8:

  ARM: ux500: regulators: Remove dead code for SD-card regulator
(2013-12-13 10:30:20 +0100)

----------------------------------------------------------------
Ux500 device tree patches for v3.14, take 2

- Delete some unused U8540 UART platform data.

- MMC/SD-fixes from Ulf Hansson so everything works with
  the device tree again.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: ux500: delete U8540 UART auxdata

Ulf Hansson (3):
      ARM: ux500: Refactor common DT configs for sdi[n] devices
      ARM: ux500: Configure regulator for I/O voltage for SD-card slot
      ARM: ux500: regulators: Remove dead code for SD-card regulator

 arch/arm/boot/dts/ste-href.dtsi               |  2 --
 arch/arm/boot/dts/ste-hrefprev60.dtsi         |  7 +++--
 arch/arm/boot/dts/ste-hrefv60plus.dtsi        | 40 ++-------------------------
 arch/arm/boot/dts/ste-snowball.dts            |  6 ++--
 arch/arm/mach-ux500/board-mop500-regulators.c | 14 ----------
 arch/arm/mach-ux500/board-mop500-regulators.h |  1 -
 arch/arm/mach-ux500/cpu-db8500.c              |  4 ---
 7 files changed, 10 insertions(+), 64 deletions(-)
