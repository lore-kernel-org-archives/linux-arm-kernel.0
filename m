From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:01:01 +0100
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <5398031.yXPovc3gIR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 816c60c131d95d6b0c7e119f89a1f1cb8d232fd8:

  arm64: tegra: Add missing Smaug revision (2016-12-08 00:23:34 +0100)

----------------------------------------------------------------
ARM: SoC non-urgent fixes for v4.10

As usual, we queue up a few fixes that don't seem urgent enough to go in
through -rc, or that just came a little too late given their size.

The zx fixes make the platform finally boot on real hardware, the
davinci and imx31 get the DT support working better for some of
the machines that are still normally used with classic board files.
One tegra fix is important for new bootloader versions, but the
bug has been around for a while without anyone noticing.

The other changes are mostly cosmetic.

----------------------------------------------------------------
Alexandre Courbot (2):
      arm64: tegra: Add VDD_GPU regulator to Jetson TX1
      arm64: tegra: Add missing Smaug revision

Arnd Bergmann (1):
      Merge tag 'socfpga_updates_for_v4.10' of git://git.kernel.org/.../dinguyen/linux into next/fixes-non-critical

Christophe JAILLET (2):
      ARM: spear: Fix error handling
      ARM: zx: Fix error handling

Christopher Spinrath (1):
      ARM: dts: imx6q-cm-fx6: fix fec pinctrl

Colin King (1):
      ARM: socfpga: fix spelling mistake in error message

David Lechner (1):
      ARM: davinci: da850: Fix pwm name matching

Geliang Tang (2):
      ARM: ixp4xx: drop duplicate header gpio.h
      ARM: lpc32xx: drop duplicate header device.h

Grygorii Strashko (1):
      soc: ti: qmss: fix the case when !SMP

Johan Hovold (1):
      bus: vexpress-config: fix device reference leak

Jun Nie (1):
      arm64: dts: zx: Fix gic GICR property

Laurent Pinchart (1):
      ARM: OMAP2+: Remove the omapdss_early_init_of() function

Lucas Stach (1):
      ARM: dts: imx6qp: correct LDB clock inputs

Markus Elfring (1):
      ARM: OMAP2+: pm-debug: Use seq_putc() in two functions

Milo Kim (1):
      mfd: tps65217: Fix mismatched interrupt number

Olof Johansson (3):
      Merge tag 'davinci-fixes-for-v4.9' of git://git.kernel.org/.../nsekhar/linux-davinci into next/fixes-non-critical
      Merge tag 'imx-fix-nc-4.10' of git://git.kernel.org/.../shawnguo/linux into next/fixes-non-critical
      Merge tag 'omap-for-v4.10/fixes-not-urgent-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical

Shawn Guo (1):
      arm64: dts: zte: clean up gic-v3 redistributor properties

Stefan Agner (1):
      ARM: dts: imx7d-pinfunc: fix UART pinmux defines

Vladimir Zapolskiy (4):
      ARM: dts: imx31: fix clock control module interrupts description
      ARM: dts: imx31: move CCM device node to AIPS2 bus devices
      clk: imx31: fix rewritten input argument of mx31_clocks_init()
      ARM: clk: imx31: properly init clocks for machines with DT

 .../devicetree/bindings/clock/imx31-clock.txt      |  2 +-
 arch/arm/boot/dts/imx31.dtsi                       | 14 +++---
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  1 -
 arch/arm/boot/dts/imx6qp.dtsi                      | 10 +++++
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 12 +++--
 arch/arm/mach-davinci/da850.c                      | 48 ++++++++++++++++++--
 arch/arm/mach-davinci/da8xx-dt.c                   | 10 ++---
 arch/arm/mach-imx/common.h                         |  1 -
 arch/arm/mach-imx/imx31-dt.c                       |  6 ---
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |  1 -
 arch/arm/mach-lpc32xx/phy3250.c                    |  1 -
 arch/arm/mach-omap2/board-generic.c                |  2 -
 arch/arm/mach-omap2/common.h                       |  1 -
 arch/arm/mach-omap2/display.c                      |  5 ---
 arch/arm/mach-omap2/pm-debug.c                     |  5 +--
 arch/arm/mach-socfpga/l2_cache.c                   |  2 +-
 arch/arm/mach-spear/time.c                         |  2 +-
 arch/arm/mach-zx/zx296702-pm-domain.c              |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 18 ++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |  3 +-
 arch/arm64/boot/dts/zte/zx296718.dtsi              |  9 +---
 drivers/bus/vexpress-config.c                      |  7 ++-
 drivers/clk/imx/clk-imx31.c                        | 52 +++++++++++-----------
 drivers/soc/ti/knav_qmss_queue.c                   |  2 +-
 include/linux/mfd/tps65217.h                       | 11 +++--
 25 files changed, 140 insertions(+), 87 deletions(-)
