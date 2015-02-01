From: olof@lixom.net (Olof Johansson)
Date: Sun, 1 Feb 2015 09:19:53 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20150201171953.GA9561@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 4b3415c9363f828e7f1e45edecb57930849d5d5b:

  Merge tag 'imx-fixes-3.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2015-01-23 14:23:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-for-linus

for you to fetch changes up to 28111dda37e653781efc73c06229f006739b3982:

  Merge tag 'renesas-soc-fixes3-for-v3.19' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2015-02-01 08:51:12 -0800)

----------------------------------------------------------------
ARM: SoC fixes

One more week's worth of fixes. Worth pointing out here are:

- A patch fixing detaching of iommu registrations when a device is removed --
  earlier the ops pointer wasn't managed properly
- Another set of Renesas boards get the same GIC setup fixup as others have in
  previous -rcs
- Serial port aliases fixups for sunxi. We did the same to tegra but we
  caught that in time before the merge window due to more machines being
  affected. Here it took longer for anyone to notice.
- A couple more DT tweaks on sunxi
- A follow-up patch for the mvebu coherency disabling in last -rc batch

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sunxi: Fix usb-phy support for sun4i/sun5i

Hans de Goede (2):
      ARM: dts: sun6i: ippo-q8h-v5: Fix serial0 alias
      ARM: dts: sun4i: Add simplefb node with de_fe0-de_be0-lcd0-hdmi pipeline

Laurent Pinchart (1):
      arm: dma-mapping: Set DMA IOMMU ops in arm_iommu_attach_device()

Magnus Damm (2):
      ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
      ARM: shmobile: r8a7790: Instantiate GIC from C board code in legacy builds

Maxime Ripard (1):
      ARM: sunxi: dt: Fix aliases

Olof Johansson (3):
      Merge tag 'sunxi-fixes-for-3.19' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'mvebu-fixes-3.19-6' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'renesas-soc-fixes3-for-v3.19' of git://git.kernel.org/.../horms/renesas into fixes

Thomas Petazzoni (1):
      ARM: mvebu: don't set the PL310 in I/O coherency mode when I/O coherency is disabled

 arch/arm/boot/dts/sun4i-a10.dtsi                 | 20 ++++-----
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  6 +++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  8 +---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 ++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  4 ++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  4 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  9 +---
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  6 ---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  6 +++
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  8 ++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  3 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  8 ----
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  4 ++
 arch/arm/boot/dts/sun8i-a23.dtsi                 |  9 ----
 arch/arm/boot/dts/sun9i-a80-optimus.dts          |  5 +++
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 10 -----
 arch/arm/mach-mvebu/coherency.c                  |  7 ++++
 arch/arm/mach-shmobile/board-ape6evm.c           | 20 +++++++++
 arch/arm/mach-shmobile/board-lager.c             | 13 ++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c         |  2 +
 arch/arm/mach-shmobile/timer.c                   | 12 ++++++
 arch/arm/mm/dma-mapping.c                        | 53 +++++++++++++++++-------
 22 files changed, 150 insertions(+), 71 deletions(-)
