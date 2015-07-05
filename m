From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 5 Jul 2015 22:34:29 +0200
Subject: [GIT PULL] Allwinner late changes for 4.2
Message-ID: <20150705203429.GA21927@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is a bunch of late patches (because I forgot about them) for the
4.2 merge window.

They're not really controversial, are fixing some issues for the A33
and H3 not having the reset controller initialised soon enough (by
adding their compatible to the already existing DT machine), and the
clock protection code not being run, resulting in the CPU (mainly)
clock being shut down at the end of the boot.

They've also been in linux-next for quite some time, so I don't expect
any breakage from them.

Thanks!
Maxime

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-late-for-4.2

for you to fetch changes up to 5738563bf6f2f1631dc71a35293b135f90969a35:

  ARM: sunxi: Enable simplefb in the defconfig (2015-07-05 16:33:56 +0200)

----------------------------------------------------------------
Allwinner late changes for 4.2

A bunch of defconfig changes, and some patches to make the Allwinner H3 and
A33 boot properly.

----------------------------------------------------------------
Jens Kuske (2):
      Documentation: sunxi: Update Allwinner SoC documentation
      ARM: sunxi: Introduce Allwinner H3 support

Maxime Ripard (1):
      ARM: sunxi: Enable simplefb in the defconfig

Timo Sigurdsson (1):
      ARM: Remove deprecated symbol from defconfig files

Vishnu Patekar (1):
      ARM: sunxi: Add Machine support for A33

 Documentation/arm/sunxi/README                  | 18 +++++++++++++++++-
 Documentation/devicetree/bindings/arm/sunxi.txt |  2 ++
 arch/arm/configs/multi_v7_defconfig             |  1 -
 arch/arm/configs/sunxi_defconfig                |  6 +++++-
 arch/arm/mach-sunxi/Kconfig                     |  2 +-
 arch/arm/mach-sunxi/sunxi.c                     |  5 ++++-
 drivers/clk/sunxi/clk-sunxi.c                   |  1 +
 7 files changed, 30 insertions(+), 5 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150705/cbb3966f/attachment.sig>
