From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:15 +0200
Subject: [PATCH 0/5] ARM: Socionext MB86S71 and Fujitsu F-Cue enablement
Message-ID: <20170625170020.11791-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial Device Trees for the Socionext MB86S71 SoC and
the Fujitsu F-Cue board. A clk driver and a gpio driver are already merged,
although the clk driver does not build for lack of an scb mailbox driver.
I am not familiar with the circumstances of those older efforts.

My proposal is to disable the build of the clk driver for now. This allows
to introduce the Kconfig symbol without breaking the build.

With the Device Tree added here it is possible to boot into an initrd,
with one CPU core up.

Cf. https://en.opensuse.org/HCL:F-Cue

More experimental patches at:
https://github.com/afaerber/linux/commits/f-cue-next

Have a lot of fun!

Cheers,
Andreas

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Satoru OKAMOTO <okamoto.satoru@socionext.com>
Cc: devicetree at vger.kernel.org

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Andy Green <andy.green@linaro.org>
Cc: Vincent Yang <vincent.yang@socionext.com>
Cc: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
Cc: Michael Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

Andreas F?rber (5):
  clk: mb86s7x: Suppress build
  ARM: Prepare Socionext MB86S71
  dt-bindings: arm: Document Socionext MB86S71 and Fujitsu F-Cue
  ARM: dts: Add Socionext MB86S71 and Fujitsu F-Cue
  ARM: dts: mb86s71-f-cue: Add fake UART0 clock

 .../devicetree/bindings/arm/socionext.txt          |  17 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/mb86s71-f-cue.dts                |  46 ++++++
 arch/arm/boot/dts/mb86s71.dtsi                     | 178 +++++++++++++++++++++
 arch/arm/mach-mb86s7x/Kconfig                      |  10 ++
 arch/arm/mach-mb86s7x/Makefile                     |   1 +
 drivers/clk/Makefile                               |   2 +-
 9 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext.txt
 create mode 100644 arch/arm/boot/dts/mb86s71-f-cue.dts
 create mode 100644 arch/arm/boot/dts/mb86s71.dtsi
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile

-- 
2.12.3
