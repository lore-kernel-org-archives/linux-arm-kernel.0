From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 23:36:59 +0100
Subject: [GIT PULL] Nomadik devicetree and cleanups
In-Reply-To: <20130128213135.GA3047@quad.lixom.net>
References: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
 <20130128213135.GA3047@quad.lixom.net>
Message-ID: <CACRpkdaHo_xLwqUDF9C71HbuGEcJHg_Jrsf0gCSPYXa4E+yJGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 10:31 PM, Olof Johansson <olof@lixom.net> wrote:

> Would you mind rebasing on top of the depends/cleanup branch in arm-soc, sort
> out the breakage (and test it) and resubmit?

So Olof, please try this instead, based on the ARM depends/cleanup HEAD
when I fetched it:

The following changes since commit f8060f5446b1f2782f0a8ca9be2d870ea4198aee:

  Merge tag 'gic-vic-to-irqchip' of
git://sources.calxeda.com/kernel/linux into next/cleanup (2013-01-14
19:55:03 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nmk-dt-on-cleanups

for you to fetch changes up to dea3eacd087cfa692ea20aafbfaf4827607afe45:

  ARM: nomadik: get rid of <mach/hardware.h> (2013-01-28 23:25:40 +0100)

----------------------------------------------------------------
Nomadik Device Tree conversion rebased on ARM SoC cleanup branch

This patch set converts the Nomadik (mach-nomadik) to
Device Tree and delete the old board files, paving the
road for single zImage.

----------------------------------------------------------------
Linus Walleij (11):
      ARM: nomadik: move last custom calls to pinctrl
      ARM: nomadik: initial devicetree support
      ARM: nomadik: move pin maps to cpu file
      ARM: nomadik: move remaining PrimeCells to device tree
      ARM: nomadik: add FSMC NAND
      ARM: nomadik: move GPIO and pinctrl to device tree
      ARM: nomadik: convert SMSC91x ethernet to device tree
      ARM: nomadik: migrate MMC/SD card support to device tree
      ARM: nomadik: add I2C devices to the device tree
      ARM: nomadik: delete old board files
      ARM: nomadik: get rid of <mach/hardware.h>

 .../devicetree/bindings/arm/ste-nomadik.txt        |  27 ++
 .../devicetree/bindings/mtd/fsmc-nand.txt          |   2 +-
 arch/arm/Kconfig                                   |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  30 ++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 256 +++++++++++++++
 arch/arm/mach-nomadik/Kconfig                      |  10 +-
 arch/arm/mach-nomadik/Makefile                     |   6 -
 arch/arm/mach-nomadik/board-nhk8815.c              | 353 --------------------
 arch/arm/mach-nomadik/cpu-8815.c                   | 358 +++++++++++++++------
 arch/arm/mach-nomadik/cpu-8815.h                   |   4 -
 arch/arm/mach-nomadik/i2c-8815nhk.c                |  88 -----
 arch/arm/mach-nomadik/include/mach/hardware.h      |  90 ------
 arch/arm/mach-nomadik/include/mach/irqs.h          |   2 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   1 -
 drivers/mtd/nand/fsmc_nand.c                       |   1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |   4 +
 17 files changed, 588 insertions(+), 647 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ste-nomadik.txt
 create mode 100644 arch/arm/boot/dts/ste-nomadik-s8815.dts
 create mode 100644 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
 delete mode 100644 arch/arm/mach-nomadik/board-nhk8815.c
 delete mode 100644 arch/arm/mach-nomadik/cpu-8815.h
 delete mode 100644 arch/arm/mach-nomadik/i2c-8815nhk.c
 delete mode 100644 arch/arm/mach-nomadik/include/mach/hardware.h
