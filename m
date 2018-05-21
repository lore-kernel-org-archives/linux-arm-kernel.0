From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 May 2018 12:41:32 -0700
Subject: [GIT PULL 3/3] more omap dts changes for v4.18 merge window
In-Reply-To: <pull-1526925630-789198@atomide.com>
References: <pull-1526925630-789198@atomide.com>
Message-ID: <pull-1526925630-789198@atomide.com-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 8dfa75524a0e0e2b4eaf2a3dc178f6b4d8db85d9:

  ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410 (2018-05-03 10:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-part2-signed

for you to fetch changes up to 0dbf99542caf8a767ea0ac286ca8077cc5e8bd32:

  ARM: dts: am3517-evm: Add User LEDs and Pushbutton (2018-05-18 14:07:38 -0700)

----------------------------------------------------------------
Second set of dts changes for omap variants for v4.18 merge window

This series of changes contains fixes for already queued tps65218
IRQ_TYPE, and fixes for omap3 and am335x use of IRQ_TYPE. There are
also addition of oscillator clock for logicpd omap3 boards and a series
of changes to improve support for am3517-evm board. And there is also
a change to configure WLAN for am437x-sk-evm.

----------------------------------------------------------------
Adam Ford (11):
      ARM: dts: logicpd-torpedo: Add fixed 26MHz clock as fck for twl
      ARM: dts: logicpd-som-lv: Add fixed 26MHz clock as fck for twl
      ARM: dts: am3517: Add pinmuxing, CD and WP for MMC1
      ARM: dts: am3517-evm: Split off SOM features from baseboard
      ARM: dts: am3517-som: Add TI TPS65023 regulators
      ARM: dts: am3517-som: Associate cpu to regulator supply
      ARM: dts: am3517-evm: Add LCD panel type 15 support
      ARM: dts: am3517-som: Add Seiko Instruments RTC s35390a
      ARM: dts: logicpd-som-lv: Fix Touchscreen controller
      ARM: dts: am3517-evm: Add I/O expander for User DIP switches and LEDS
      ARM: dts: am3517-evm: Add User LEDs and Pushbutton

Eyal Reizer (1):
      ARM: dts: am437x-sk-evm: add wilink8 support

Hern?n Gonzalez (5):
      ARM: dts: am335x-baltos-ir3220: Use IRQ_TYPE specifier
      ARM: dts: am335x-baltos-ir5221: Use IRQ_TYPE specifier
      ARM: dts: am335x-baltos.dtsi: Use IRQ_TYPE specifier
      ARM: dts: am335x-boneblue: Use IRQ_TYPE specifier
      ARM: dts: omap3-pandora-common: Use IRQ_TYPE specifier

Peter Ujfalusi (5):
      ARM: dts: am335x-evmsk: Add phandle for the backlight for the panel
      ARM: dts: am437x-gp-evm: Fixup (again) tps65218 irq type
      ARM: dts: am437x-cm-t43: Fixup (again) tps65218 irq type
      ARM: dts: am437x-epos-evm: Fixup (again) tps65218 irq type
      Revert "ARM: dts: am437x-sk-evm: Correct tps65218 irq type"

Rob Herring (2):
      ARM: dts: omap: fix OF graph in omap3-devkit8000
      ARM: dts: omap: fix OMAP3 CM-T3x OF graph video connectors

Tony Lindgren (1):
      Merge branch 'omap-for-v4.18/dt-fixes' into omap-for-v4.18/dt

 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |   2 +-
 arch/arm/boot/dts/am335x-boneblue.dts              |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   3 +-
 arch/arm/boot/dts/am3517-evm.dts                   | 233 ++++++++++++++++++++-
 arch/arm/boot/dts/am3517-som.dtsi                  | 142 +++++++++++++
 arch/arm/boot/dts/am437x-cm-t43.dts                |   2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 117 ++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  21 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |  10 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   9 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   5 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |   2 +-
 18 files changed, 538 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517-som.dtsi
