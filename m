From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 21:00:30 +0400
Subject: [GIT PULL v2] Some Cavium CNS3xxx updates for 2.6.36
Message-ID: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

The main reason for the v2 is, obviously, the defconfigs situation.
I dropped the defconfig update in this pull request.

There are also few improvements as suggested by by Ben Dooks and
Sergei Shtylyov, plus there is no longer the ugly
"../../../drivers/mmc/host/sdhci.h" include anymore.

As usual, I'm posting the updated patches as well.

The following changes since commit 9dda696f0de87a2e5cfabb147e28c76b7d3c6846:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (4):
      ARM: cns3xxx: Use IO memory accessors everywhere
      ARM: cns3xxx: Add support for PCI Express ports
      ARM: cns3xxx: Add support for SDHCI controllers
      ARM: cns3xxx: Add support for AHCI controllers

 arch/arm/Kconfig                             |    3 +-
 arch/arm/mach-cns3xxx/Makefile               |    3 +-
 arch/arm/mach-cns3xxx/cns3420vb.c            |    4 +
 arch/arm/mach-cns3xxx/devices.c              |  111 ++++++++
 arch/arm/mach-cns3xxx/devices.h              |   20 ++
 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h |   91 +++---
 arch/arm/mach-cns3xxx/pcie.c                 |  389 ++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/pm.c                   |   31 ++-
 8 files changed, 596 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/mach-cns3xxx/devices.c
 create mode 100644 arch/arm/mach-cns3xxx/devices.h
 create mode 100644 arch/arm/mach-cns3xxx/pcie.c
