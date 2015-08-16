From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Aug 2015 21:38:16 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.2-rc
Message-ID: <20150816193816.GA12008@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Apologies for the last minute pull request. No big deal if it doesn't
make it before -rc cut.


Thanks!

-Olof


The following changes since commit c1bfa985ded82cacdfc6403e78f329c44e35534a:

  ARM: dts: keystone: fix dt bindings to use post div register for mainpll (2015-07-31 22:30:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-for-linus

for you to fetch changes up to 02149517acbbf5cf0d1819024977963093168106:

  Merge tag 'keystone-dts-late-fixes-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone into fixes (2015-08-16 21:29:57 +0200)

----------------------------------------------------------------
ARM: SoC fixes

A smallish batch of fixes, a little more than expected this late, but
all fixes are contained to their platforms and seem reasonably low risk:

- A somewhat large SMP fix for ux500 that still seemed warranted to include here
- OMAP DT fixes for pbias regulator specification that broke due to some DT
  reshuffling
- PCIe IRQ routing bugfix for i.MX
- Networking fixes for keystone
- Runtime PM for OMAP GPMC
- A couple of error path bug fixes for exynos

----------------------------------------------------------------
Kishon Vijay Abraham I (4):
      ARM: dts: omap243x: Fix broken pbias device creation
      ARM: dts: OMAP4: Fix broken pbias device creation
      ARM: dts: OMAP5: Fix broken pbias device creation
      ARM: dts: dra7: Fix broken pbias device creation

Linus Walleij (1):
      ARM: ux500: add an SMP enablement type and move cpu nodes

Lucas Stach (1):
      ARM: imx6: correct i.MX6 PCIe interrupt routing

Murali Karicheri (2):
      ARM: dts: keystone: fix the clock node for mdio
      ARM: dts: keystone: Fix the mdio bindings by moving it to soc specific file

Olof Johansson (5):
      Merge tag 'omap-for-v4.2/fixes-rc5' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'samsung-mach-fixes-4.2' of https://github.com/krzk/linux into fixes
      Merge tag 'imx-fixes-4.2-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.2/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'keystone-dts-late-fixes-v2' of git://git.kernel.org/.../ssantosh/linux-keystone into fixes

Tomeu Vizoso (1):
      memory: omap-gpmc: Don't try to save uninitialized GPMC context

Vladimir Zapolskiy (2):
      ARM: EXYNOS: Fix potentian kfree() of ro memory
      ARM: EXYNOS: fix double of_node_put() on error path

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/dra7.dtsi                    |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                 |  8 ++--
 arch/arm/boot/dts/k2e.dtsi                     | 15 ++++++--
 arch/arm/boot/dts/k2hk.dtsi                    | 11 ++++++
 arch/arm/boot/dts/k2l.dtsi                     | 16 +++++---
 arch/arm/boot/dts/keystone.dtsi                | 11 ------
 arch/arm/boot/dts/omap2430.dtsi                |  3 +-
 arch/arm/boot/dts/omap4.dtsi                   |  3 +-
 arch/arm/boot/dts/omap5.dtsi                   |  3 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi              | 53 +++++++++++++-------------
 arch/arm/mach-exynos/pm_domains.c              |  3 +-
 drivers/memory/omap-gpmc.c                     |  6 +++
 13 files changed, 79 insertions(+), 56 deletions(-)
