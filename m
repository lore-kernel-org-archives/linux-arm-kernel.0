From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 Nov 2012 04:21:16 +0000
Subject: [GIT PULL] ARM: ixp4xx: fixes for v3.7
Message-ID: <mailman.7.1353558083.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/ixp4xx_fixes_for_3.7

for you to fetch changes up to 0d2c9f0517e915ce03a04e91d3207827e0d274a8:

  IXP4xx: use __iomem for MMIO (2012-11-22 03:36:45 +0000)

----------------------------------------------------------------
ixp4xx fixes for v3.7

----------------------------------------------------------------
Arnd Bergmann (1):
      IXP4xx: use __iomem for MMIO

Krzysztof Haasa (9):
      IXP4xx: Fix Goramo MultiLink platform compilation.
      IXP4xx: Fix off-by-one bug in Goramo MultiLink platform.
      IXP4xx: HW pseudo-random generator is available on IXP45x/46x only.
      IXP4xx: ixp4xx_crypto driver requires Queue Manager and NPE drivers.
      IXP4xx: Remove time limit for PCI TRDY to enable use of slow devices.
      WAN: Remove redundant HDLC info printed by IXP4xx HSS driver.
      IXP4xx crypto: MOD_AES{128,192,256} already include key size.
      IXP4xx: Always ioremap() Queue Manager MMIO region at boot.
      IXP4xx: map CPU config registers within VMALLOC region.

Tim Gardner (1):
      ixp4xx: Declare MODULE_FIRMWARE usage

 arch/arm/mach-ixp4xx/common-pci.c               |  1 +
 arch/arm/mach-ixp4xx/common.c                   | 13 +++----
 arch/arm/mach-ixp4xx/goramo_mlr.c               |  3 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S |  4 +--
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 46 ++++++++++---------------
 arch/arm/mach-ixp4xx/include/mach/qmgr.h        | 12 +++----
 arch/arm/mach-ixp4xx/ixp4xx_npe.c               |  9 ++++-
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c              | 12 +------
 drivers/char/hw_random/Kconfig                  |  6 ++--
 drivers/char/hw_random/ixp4xx-rng.c             |  5 ++-
 drivers/crypto/Kconfig                          |  2 +-
 drivers/crypto/ixp4xx_crypto.c                  | 12 +++----
 drivers/net/wan/ixp4xx_hss.c                    |  2 +-
 13 files changed, 59 insertions(+), 68 deletions(-)
