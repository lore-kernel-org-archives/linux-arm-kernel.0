From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 00:23:09 -0700
Subject: [GIT PULL] ARM: SoC fixes for v4.3
Message-ID: <20151031072309.GA24091@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 55f41297576ddb7868af2f13f3a8107178dee2d0:

  Merge tag 'mvebu-fixes-4.3-2' of git://git.infradead.org/linux-mvebu into fixes (2015-10-21 17:03:37 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 53dd186b3fb7254ae0cb4d6648abb5589aaa8c2d:

  Merge tag 'omap-for-v4.3/fixes-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2015-10-31 01:42:13 +0000)

----------------------------------------------------------------
ARM: SoC fixes for v4.3

This should be our final batch of fixes for 4.3:

- A patch from Sudeep Holla that fixes annotation of wakeup sources properly,
  old unused format seems to have spread through copying.
- Two patches from Tony for OMAP. One dealing with MUSB setup problems due to
  runtime PM being enabled too early on the parent device. The other fixes
  IRQ numbering for OMAP1.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix incorrect INT_DMA_LCD

Olof Johansson (1):
      Merge tag 'omap-for-v4.3/fixes-rc7' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Sudeep Holla (1):
      ARM: dts: fix gpio-keys wakeup-source property

Tony Lindgren (1):
      usb: musb: omap2430: Fix regression caused by driver core change

 arch/arm/boot/dts/emev2-kzm9d.dts             |  8 ++++----
 arch/arm/boot/dts/ste-snowball.dts            | 10 ++++-----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 +++++------
 drivers/usb/musb/omap2430.c                   | 29 +++++++++++++++++++++------
 include/linux/omap-dma.h                      |  2 +-
 5 files changed, 39 insertions(+), 22 deletions(-)
