From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Dec 2015 10:40:03 -0800
Subject: [GIT PULL] ARM: SoC fixes for v4.4
Message-ID: <20151227184003.GA4775@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

A smallish set of fixes that we've been sitting on for a while now,
flushing the queue here so they go in.


Thanks!


-Olof


The following changes since commit 7f4c977849d494a1ff173fbc226b69192ec02c90:

  Merge tag 'imx-fixes-4.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2015-12-11 16:14:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 80373d37bee562060ce4d3e5272b708e8db5d1fc:

  ARM: tegra: Fix suspend hang on Tegra124 Chromebooks (2015-12-22 15:41:37 -0800)

----------------------------------------------------------------
ARM: SoC fixes for v4.4

A handful of fixes for OMAP, i.MX, Allwinner and Tegra:

- A clock rate and a PHY setup fix for i.MX6Q/DL
- A couple of fixes for the reduced serial bus (sunxi-rsb) on Allwinner
- UART wakeirq fix for an OMAP4 board, timer config fixes for AM43XX.
- Suspend fix for Tegra124 Chromebooks
- Fix for missing implicit include that's different between ARM/ARM64

----------------------------------------------------------------
Bai Ping (1):
      ARM: dts: imx: Fix the assigned-clock mismatch issue on imx6q/dl

Chen-Yu Tsai (2):
      bus: sunxi-rsb: Fix primary PMIC mapping hardware address
      bus: sunxi-rsb: Fix peripheral IC mapping runtime address

Dan Carpenter (1):
      bus: sunxi-rsb: unlock on error in sunxi_rsb_read()

Felipe Balbi (1):
      ARM: OMAP2+: AM43xx: select ARM TWD timer

Grygorii Strashko (1):
      ARM: OMAP2+: am43xx: enable GENERIC_CLOCKEVENTS_BROADCAST

Jon Hunter (1):
      ARM: tegra: Fix suspend hang on Tegra124 Chromebooks

Karsten Merker (1):
      ARM: dts: sunxi: sun6i-a31s-primo81.dts: add touchscreen axis swapping property

Kevin Hilman (1):
      Merge tag 'sunxi-fixes-for-4.4' of https://git.kernel.org/.../mripard/linux into fixes

Krzysztof Ha??asa (1):
      ARM: dts: imx6: Fix Ethernet PHY mode on Ventana boards

Lijun Pan (1):
      fsl-ifc: add missing include on ARM64

Olof Johansson (2):
      Merge tag 'imx-fixes-4.4-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.4/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Tony Lindgren (1):
      ARM: dts: Fix UART wakeirq for omap4 duovero parlor

 arch/arm/boot/dts/imx6q-gw5400-a.dts       | 2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   | 6 +++---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 4 ++++
 arch/arm/boot/dts/sun6i-a31s-primo81.dts   | 1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi       | 2 +-
 arch/arm/mach-omap2/Kconfig                | 2 ++
 arch/arm/mach-omap2/timer.c                | 6 ++++++
 drivers/bus/sunxi-rsb.c                    | 8 ++++----
 drivers/memory/fsl_ifc.c                   | 1 +
 13 files changed, 27 insertions(+), 13 deletions(-)
