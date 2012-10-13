From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 13 Oct 2012 23:22:12 +0200
Subject: [PULL REQ] IXP4xx changes for Linux 3.7
Message-ID: <m3bog6m5iz.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

please pull my ARM IXP4xx changes for 3.7:

The following changes since commit 4d7127dace8cf4b05eb7c8c8531fc204fbb195f4:

"Merge branch 'for-linus' of git://git.kernel.org/.../jmorris/linux-security"
(2012-10-13 11:29:00 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux.git next

for you to fetch changes up to b94740b3b38fd8e37fcd3bb06a18ec2796061c7d:
  IXP4xx: use __iomem for MMIO (2012-10-13 20:37:30 +0200)

Build-tested for now. This is based on your current tree tip because it
depends on commits following 3.6 release.

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      IXP4xx: use __iomem for MMIO

Krzysztof Ha?asa (9):
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
 arch/arm/mach-ixp4xx/common.c                   | 13 +++++--------
 arch/arm/mach-ixp4xx/goramo_mlr.c               |  3 ++-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S |  4 ++--
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 46 +++++++++++++++++++--------------------------
 arch/arm/mach-ixp4xx/include/mach/qmgr.h        | 12 ++++++------
 arch/arm/mach-ixp4xx/ixp4xx_npe.c               |  9 ++++++++-
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c              | 12 +-----------
 drivers/char/hw_random/Kconfig                  |  6 +++---
 drivers/char/hw_random/ixp4xx-rng.c             |  5 ++++-
 drivers/crypto/Kconfig                          |  2 +-
 drivers/crypto/ixp4xx_crypto.c                  | 12 ++++++------
 drivers/net/wan/ixp4xx_hss.c                    |  2 +-
 13 files changed, 59 insertions(+), 68 deletions(-)

-- 
Krzysztof Halasa
