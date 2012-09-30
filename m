From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 29 Sep 2012 21:50:12 -0400
Subject: [GIT PULL] ARM: mvebu: cache-l2x0 DT for v3.7
Message-ID: <20120930015012.GB17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based on arm-soc/late/kirkwood
 - Patches going through rmk's patch tracker:
    - arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
    - arm: cache-l2x0: add an optional register to save/restore
    - arm: cache-l2x0: add support for Aurora L2 cache ctrl

    - feature-use dependency only.  No build breakage or failed boot
      should occur.  Until patches from rmk's tracker land, driver
      won't know about compatible property, so it's like the driver
      isn't there.

Adds:
 - cache-l2x0 DT entry for Marvell Armada (mvebu) SoCs

The following changes since commit 46f2007c1efadfa4071c17e75f140c47f09293de:

  ARM: mvebu: fix build breaks from multi-platform conversion (2012-09-28 22:27:07 +0200)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git mvebu/cache-l2x0

Gregory CLEMENT (3):
      arm: mvebu: add L2 cache support
      arm: mvebu: add Aurora L2 Cache Controller to the DT
      arm: l2x0: add aurora related properties to OF binding

 Documentation/devicetree/bindings/arm/l2cc.txt |    9 +++++++++
 arch/arm/boot/dts/armada-370.dtsi              |    6 ++++++
 arch/arm/boot/dts/armada-xp.dtsi               |    7 +++++++
 arch/arm/mach-mvebu/Kconfig                    |    1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c        |    4 ++++
 5 files changed, 27 insertions(+), 0 deletions(-)
