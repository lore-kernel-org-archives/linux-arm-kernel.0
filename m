From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 1 Jun 2010 20:54:09 +0400
Subject: [GIT PULL] Some Cavium CNS3xxx updates for 2.6.36
Message-ID: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

As Linus' merge window is now officially closed, I believe
we can start requesting pulls for -next?

It's that early because I'd like the already posted patches
separated from any further work to be submitted.

And the following leftovers were posted long ago, but were
waiting for -mm and libata trees:

- cns3xxx: Add support for SDHCI controllers
  http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012149.html
- cns3xxx: Add support for AHCI controllers
  http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012150.html
- cns3xxx: Add support for PCI Express ports
  http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012462.html

For convenience I'm posting the patches again + defconfig update,
and if everything looks reasonable, linux-cns3xxx's master branch
is ready for you to pull.

Thanks!

The following changes since commit 9dda696f0de87a2e5cfabb147e28c76b7d3c6846:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (4):
      ARM: cns3xxx: Add support for PCI Express ports
      ARM: cns3xxx: Add support for SDHCI controllers
      ARM: cns3xxx: Add support for AHCI controllers
      ARM: cns3xxx: Update defconfig to enable AHCI, PCIe and net devices

 arch/arm/Kconfig                     |    3 +-
 arch/arm/configs/cns3420vb_defconfig |  410 ++++++++++++++++++++++++++++++++--
 arch/arm/mach-cns3xxx/Makefile       |    3 +-
 arch/arm/mach-cns3xxx/cns3420vb.c    |    3 +
 arch/arm/mach-cns3xxx/core.c         |   30 +++
 arch/arm/mach-cns3xxx/devices.c      |  206 +++++++++++++++++
 arch/arm/mach-cns3xxx/devices.h      |   20 ++
 arch/arm/mach-cns3xxx/pcie.c         |  352 +++++++++++++++++++++++++++++
 8 files changed, 1008 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-cns3xxx/devices.c
 create mode 100644 arch/arm/mach-cns3xxx/devices.h
 create mode 100644 arch/arm/mach-cns3xxx/pcie.c

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
