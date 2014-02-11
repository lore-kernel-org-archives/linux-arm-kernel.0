From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Feb 2014 10:24:12 +0100
Subject: [GIT PULL] Ux500 AB8500 DT conversion
Message-ID: <CACRpkdZcH8gmvsH_P79mtq=ws-+9aoPe6QgXPL7GW5jAjLvrhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

the following converts the AB8500 pin configuration from board
file to device tree and removes the final pin settings board file
config.

Please pull it into an apropriate Ux500 device tree branch, I'll
possibly send more Ux500 DT stuff on top of this.

Yours,
Linus Walleij

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ab8500-dt-for-arm-soc

for you to fetch changes up to 77ad9dfc2c7e3b5ce49efc5c0c215f7c36c91cf2:

  ARM: ux500: move last AB8505 set-up to DT (2014-02-04 20:50:55 +0100)

----------------------------------------------------------------
AB8500 device tree conversion and the deletion of all
pin-related configuration from the Ux500 board files.

----------------------------------------------------------------
Linus Walleij (10):
      ARM: ux500: move AB8500 GPIOs to device tree
      ARM: ux500: move AB8500 YCBCR settings to device tree
      ARM: ux500: move AB8500 PWM out settings to device tree
      ARM: ux500: move AB8500 audio interface 1 settings to DT
      ARM: ux500: move AB8500 USB UICC settings to DT
      ARM: ux500: move AB8500 DMIC settings to DT
      ARM: ux500: move AB8500 EXTCPENA from board file to DT
      ARM: ux500: move AB8500 modem I2C settings to DT
      ARM: ux500: move AB8500 clock out pins to DT
      ARM: ux500: move last AB8505 set-up to DT

 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 428 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href-ab8505.dtsi  | 240 ++++++++++++++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi   |   1 +
 arch/arm/boot/dts/ste-hrefv60plus.dtsi  |   1 +
 arch/arm/boot/dts/ste-snowball.dts      |   1 +
 arch/arm/mach-ux500/Makefile            |   1 -
 arch/arm/mach-ux500/board-mop500-pins.c | 291 ----------------------
 arch/arm/mach-ux500/board-mop500.h      |   4 -
 arch/arm/mach-ux500/cpu-db8500.c        |  10 -
 9 files changed, 671 insertions(+), 306 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-ab8500.dtsi
 create mode 100644 arch/arm/boot/dts/ste-href-ab8505.dtsi
 delete mode 100644 arch/arm/mach-ux500/board-mop500-pins.c
