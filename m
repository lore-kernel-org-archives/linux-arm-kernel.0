From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 22 Dec 2010 03:59:55 +0300
Subject: [GIT PULL] Cavium CNS3xxx updates for 2.6.38
Message-ID: <20101222005955.GA1837@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I guess it's a bit late, and I'm sorry about that. The pull
request doesn't contain anything earth shattering though.

A small fixup for the cns3xxx_pwr_soft_rst_force() function
+ EHCI/OHCI support (all drivers/usb/ patches were acked by
Greg and Alan).

I checked that cns3xxx tree pulls without conflicts into
devel and devel-stable branches (and builds fine too).

Please pull. Thanks!

The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:
  Linus Torvalds (1):
        Linux 2.6.37-rc3

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (1):
      ARM: cns3xxx: Make cns3xxx_pwr_soft_rst_force() to actually reset blocks

Mac Lin (3):
      ARM: cns3xxx: Add new and export the old power management functions
      ARM: cns3xxx: Add architecture definition for EHCI/OHCI controller
      USB: cns3xxx: Add EHCI and OHCI bus glue for cns3xxx SOCs

 arch/arm/mach-cns3xxx/cns3420vb.c            |   54 ++++++++
 arch/arm/mach-cns3xxx/core.h                 |    2 -
 arch/arm/mach-cns3xxx/devices.c              |    1 +
 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h |    2 -
 arch/arm/mach-cns3xxx/include/mach/pm.h      |   23 ++++
 arch/arm/mach-cns3xxx/pm.c                   |   23 ++++
 drivers/usb/Kconfig                          |    2 +
 drivers/usb/host/Kconfig                     |   15 +++
 drivers/usb/host/ehci-cns3xxx.c              |  171 ++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ohci-cns3xxx.c              |  165 +++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c                  |    5 +
 12 files changed, 464 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/pm.h
 create mode 100644 drivers/usb/host/ehci-cns3xxx.c
 create mode 100644 drivers/usb/host/ohci-cns3xxx.c
