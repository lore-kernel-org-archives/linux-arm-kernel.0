From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 Sep 2015 22:50:25 -0700
Subject: [GIT PULL] ARM: SoC fixes for 4.3-rc
Message-ID: <20150927055025.GA5534@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Our first batch of fixes this merge window. Nothing really concerning,
and diffstat is a bit inflated due to some DT contents moving around on
STi platforms.

Please merge!


Thanks,

-Olof


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to e46fc90ec2612ef7578c6e3e28ad477a116e24da:

  Merge tag 'pxa-fixes-v4.3' of https://github.com/rjarzmik/linux into fixes (2015-09-26 22:23:26 -0700)

----------------------------------------------------------------
ARM: SoC fixes for v4.3-rc

Our first real batch of fixes this release cycle. There's a collection of
them here:

- A fixup for a build breakage that hits on arm64 allmodconfig in QCOM SCM
  firmware drivers
- MMC fixes for OMAP that had quite a bit of breakage this merge window.
- Misc build/warning fixes on PXA and OMAP
- A couple of minor fixes for Beagleboard X15 which is now starting to see
  a few more users in the wild

----------------------------------------------------------------
Andy Gross (1):
      firmware: qcom: scm: Add function stubs for ARM64

Axel Lin (1):
      ARM: pxa: balloon3: Fix build error

Benjamin Gaignard (1):
      ARM: sti: dt: adapt DT to fix probe/bind issues in DRM driver

Carl Frederik Werner (1):
      ARM: dts: omap3-beagle: make i2c3, ddc and tfp410 gpio work again

Dave Gerlach (1):
      ARM: OMAP2+: AM43XX: Enable autoidle for clks in am43xx_init_late

Douglas Anderson (1):
      ARM: dts: Add ddc i2c reference to veyron

Frans Klaver (1):
      ARM: OMAP3: vc: fix 'or' always true warning

Grazvydas Ignotas (2):
      ARM: dts: omap5-uevm.dts: fix i2c5 pinctrl offsets
      ARM: omap2plus_defconfig: enable GPIO_PCA953X

Grygorii Strashko (1):
      ARM: OMAP2+: omap-device: fix race deferred probe of omap_hsmmc vs omap_device_late_init

Jarkko Nikula (1):
      ARM: pxa: ssp: Fix build error by removing originally incorrect DT binding

Javier Martinez Canillas (1):
      ARM: dts: omap3-igep: Move eth IRQ pinmux to IGEPv2 common dtsi

Kevin Hilman (1):
      Merge tag 'omap-for-v4.3/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Kishon Vijay Abraham I (4):
      ARM: dts: am57xx-beagle-x15: Fix regulator populated in MMC1 dt node
      ARM: dts: Use ti,pbias compatible string for pbias
      ARM: omap2plus_defconfig: make PCF857x built-in
      ARM: dts: fix omap2+ address translation for pbias

Nicolas Chauvet (1):
      ARM: dts: Fixup model name for HP t410 dts

Nishanth Menon (6):
      ARM: dts: am57xx-beagle-x15: Add wakeup irq for mcp79410
      ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
      ARM: OMAP2+: board-generic: Remove stale of_irq macros
      ARM: DRA7: Select missing options for SoC only build
      ARM: OMAP5: Cleanup options for SoC only build
      ARM: dts: am57xx-beagle-x15: Update Phy supplies

Olof Johansson (4):
      Merge tag 'qcom-fixes-for-4.3-rc1' of git://codeaurora.org/quic/kernel/agross-msm into fixes
      Merge tag 'v4.3-rockchip32-dtsfixes1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'omap-for-v4.3/fixes-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'pxa-fixes-v4.3' of https://github.com/rjarzmik/linux into fixes

Robert Jarzmik (1):
      ARM: pxa: fix DFI bus lockups on startup

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: use palmas-usb for USB2

Teresa Remmet (1):
      ARM: dts: am335x-phycore-som: Fix mpu voltage

Tony Lindgren (5):
      ARM: OMAP2+: Fix booting if no timer parent clock is available
      ARM: omap2plus_defconfig: Enable MUSB DMA support
      ARM: dts: Fix dm814x control base to properly initialize Ethernet PHY
      Merge branch 'fixes-rc1' into omap-for-v4.3/fixes
      Merge commit 'b8c93646fd5c' into omap-for-v4.3/fixes

Vishal Mahaveer (2):
      ARM: DRA752: Add ID detect for ES2.0
      ARM: dts: DRA7: fix a typo in ethernet

 arch/arm/boot/dts/am335x-phycore-som.dtsi    |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts      | 46 ++++++++++------
 arch/arm/boot/dts/dm8148-evm.dts             |  4 +-
 arch/arm/boot/dts/dm8148-t410.dts            |  6 +-
 arch/arm/boot/dts/dm814x.dtsi                |  8 +--
 arch/arm/boot/dts/dra7.dtsi                  |  5 +-
 arch/arm/boot/dts/omap2430.dtsi              |  3 +-
 arch/arm/boot/dts/omap3-beagle.dts           |  2 +-
 arch/arm/boot/dts/omap3-igep.dtsi            |  6 --
 arch/arm/boot/dts/omap3-igep0020-common.dtsi |  6 ++
 arch/arm/boot/dts/omap3.dtsi                 | 25 +++++----
 arch/arm/boot/dts/omap4.dtsi                 |  3 +-
 arch/arm/boot/dts/omap5-uevm.dts             |  4 +-
 arch/arm/boot/dts/omap5.dtsi                 |  3 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi         |  1 +
 arch/arm/boot/dts/stih407.dtsi               | 82 ++++++++++++++--------------
 arch/arm/boot/dts/stih410.dtsi               | 82 ++++++++++++++--------------
 arch/arm/configs/omap2plus_defconfig         |  5 +-
 arch/arm/mach-omap2/Kconfig                  |  6 +-
 arch/arm/mach-omap2/board-generic.c          |  7 ---
 arch/arm/mach-omap2/id.c                     |  8 ++-
 arch/arm/mach-omap2/io.c                     |  1 +
 arch/arm/mach-omap2/omap_device.c            |  3 +-
 arch/arm/mach-omap2/pm.h                     |  3 +-
 arch/arm/mach-omap2/soc.h                    |  2 +
 arch/arm/mach-omap2/timer.c                  |  8 +--
 arch/arm/mach-omap2/vc.c                     |  2 +-
 arch/arm/mach-pxa/balloon3.c                 |  2 +-
 arch/arm/mach-pxa/include/mach/addr-map.h    |  7 +++
 arch/arm/mach-pxa/pxa3xx.c                   | 21 ++++++-
 arch/arm/plat-pxa/ssp.c                      |  1 -
 drivers/firmware/Kconfig                     |  8 +++
 drivers/firmware/Makefile                    |  3 +-
 drivers/firmware/qcom_scm-64.c               | 63 +++++++++++++++++++++
 34 files changed, 278 insertions(+), 162 deletions(-)
