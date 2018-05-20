From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 May 2018 18:23:45 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180520012345.4zutmq72hjizj3px@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:

  Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 709f490d5b594b9548577d2285ffeaad8a278b10:

  Merge tag 'tegra-for-4.17-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into fixes (2018-05-19 17:58:32 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.17-rc

A handful of fixes. I've been queuing them up a bit too long so the list
is longer than it otherwise would have been spread out across a few -rcs.

In general, it's a scattering of fixes across several platforms, nothing
truly serious enough to point out.

There's a slightly larger batch of them for the Davinci platforms due
to work to bring them back to life after some time, so there's a handful
of regressions, some of them going back very far, others more recent.

There's also a few patches fixing DT on Renesas platforms since they
changed some bindings without remaining backwards compatible, splitting
up describing LVDS as a proper bridge instead of having it as part of the
display unit. We could push for them to be backwards compatible with old
device trees, but it's likely to regress eventually if nobody's actually
using said compatibility.

----------------------------------------------------------------
Adam Ford (3):
      ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
      ARM: dts: logicpd-som-lv: Fix Audio Mute
      ARM: dts: logicpd-som-lv: Fix pinmux controller references

Bhadram Varka (1):
      arm64: tegra: Make BCM89610 PHY interrupt as active low

Cl?ment P?ron (1):
      ARM: dts: cygnus: fix irq type for arm global timer

Dan Carpenter (1):
      firmware: arm_scmi: Use after free in scmi_create_protocol_device()

Dmitry Osipenko (1):
      ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

Etienne Carriere (1):
      tee: check shm references are consistent in offset/size

Fabio Estevam (1):
      ARM: dts: imx7s: Pass the 'fsl,sec-era' property

Graeme Smecher (1):
      ARM: dts: correct missing "compatible" entry for ti81xx SoCs

Jann Horn (1):
      tee: shm: fix use-after-free via temporarily dropped reference

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: fix deferred_fiq handler

Laurent Pinchart (3):
      ARM: dts: r8a7790: Convert to new LVDS DT bindings
      ARM: dts: r8a7791: Convert to new LVDS DT bindings
      ARM: dts: r8a7793: Convert to new LVDS DT bindings

Marek Szyprowski (1):
      arm64: dts: exynos: Fix interrupt type for I2S1 device on Exynos5433

Masahiro Yamada (3):
      arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
      reset: uniphier: fix USB clock line for LD20
      arm64: dts: uniphier: stabilize ethernet of LD20 reference board

Maxime Chevallier (2):
      ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
      ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node

Nikita Yushchenko (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen bindings

Olof Johansson (13):
      Merge tag 'uniphier-fixes-v4.17' of git://git.kernel.org/.../masahiroy/linux-uniphier into fixes
      Merge tag 'renesas-fixes-for-v4.17' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'davinci-fixes-for-v4.17' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'tegra-for-4.17-fixes' of git://git.kernel.org/.../tegra/linux into fixes
      Merge tag 'tee-drv-fixes-for-4.17' of git://git.linaro.org/people/jens.wiklander/linux-tee into fixes
      Merge tag 'arm-soc/for-4.17/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'omap-for-v17/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'scmi-fixes-4.17' of git://git.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'imx-fixes-4.17' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'mvebu-fixes-4.17-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'reset-fixes-for-4.17' of git://git.pengutronix.de/pza/linux into fixes
      Merge tag 'davinci-fixes-for-v4.17-part-2' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'tegra-for-4.17-fixes-2' of git://git.kernel.org/.../tegra/linux into fixes

Russell King (1):
      ARM: keystone: fix platform_domain_notifier array overrun

Sekhar Nori (11):
      ARM: dts: da850: get rid of skeleton.dtsi
      ARM: dts: da850-lcdk: add unit name for memory node
      ARM: dts: da850: fix W=1 warnings with pinmux node
      ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup
      ARM: davinci: board-dm355-evm: fix broken networking
      ARM: davinci: fix GPIO lookup for I2C
      ARM: davinci: dm646x: fix timer interrupt generation
      ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
      ARM: davinci: board-dm646x-evm: set VPIF capture card name

Tero Kristo (1):
      ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace

Tony Lindgren (1):
      Revert "ARM: dts: logicpd-som-lv: Fix pinmux controller references"

 .../devicetree/bindings/net/marvell-pp2.txt        |  9 +--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  2 +-
 arch/arm/boot/dts/da850-lcdk.dts                   |  4 +-
 arch/arm/boot/dts/da850.dtsi                       | 13 ++++-
 arch/arm/boot/dts/dm8148-evm.dts                   |  2 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |  2 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |  2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |  2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  6 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  1 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi              | 11 +++-
 arch/arm/boot/dts/r8a7790-lager.dts                | 22 ++++++--
 arch/arm/boot/dts/r8a7790.dtsi                     | 65 +++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 12 +++-
 arch/arm/boot/dts/r8a7791-porter.dts               | 16 +++++-
 arch/arm/boot/dts/r8a7791.dtsi                     | 36 ++++++++++--
 arch/arm/boot/dts/r8a7793-gose.dts                 | 10 +++-
 arch/arm/boot/dts/r8a7793.dtsi                     | 37 ++++++++++--
 arch/arm/boot/dts/tegra20.dtsi                     |  2 +-
 arch/arm/mach-davinci/board-da830-evm.c            |  9 ++-
 arch/arm/mach-davinci/board-da850-evm.c            |  9 ++-
 arch/arm/mach-davinci/board-dm355-evm.c            | 15 ++++-
 arch/arm/mach-davinci/board-dm644x-evm.c           | 10 +++-
 arch/arm/mach-davinci/board-dm646x-evm.c           |  5 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        | 10 +++-
 arch/arm/mach-davinci/dm646x.c                     |  3 +-
 arch/arm/mach-keystone/pm_domain.c                 |  1 +
 arch/arm/mach-omap1/ams-delta-fiq.c                | 28 +++++-----
 arch/arm/mach-omap2/powerdomain.c                  |  4 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  7 ++-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |  2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  2 +-
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  8 +++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |  2 +-
 drivers/firmware/arm_scmi/driver.c                 |  1 +
 drivers/reset/reset-uniphier.c                     |  6 +-
 drivers/tee/tee_core.c                             | 11 ++++
 drivers/tee/tee_shm.c                              |  5 +-
 40 files changed, 300 insertions(+), 96 deletions(-)
