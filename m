From: mkl0301@gmail.com (mkl0301 at gmail.com)
Date: Tue, 23 Nov 2010 00:32:42 +0800
Subject: [PATCH v2 0/3] USB: add support for cns3xxx SOC's EHCI/OHCI controller
Message-ID: <1290443565-20766-1-git-send-email-mkl0301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mac Lin <mkl0301@gmail.com>

v2:
 - Changing CNS3XXX to cns3xxx in subjec for part of the patches are filtered due to "capital Triple-X in subject".

v1: 
The first patch prepare the mach-cns3xxx power management code for drivers use.
The other two patches add the bus glue for EHCI/OHCI controller in mach-cns3xxx 
and usb.

This patchset is based on linux-2.6.37-rc2

Mac Lin (3):
      ARM: cns3xxx: Add new and export the old power management functions
      ARM: cns3xxx: Add architecture definition for EHCI/OHCI controller
      USB: cns3xxx: Add EHCI and OHCI bus glue for cns3xxx SOCs

 arch/arm/mach-cns3xxx/cns3420vb.c            |   50 ++++++++
 arch/arm/mach-cns3xxx/core.h                 |    4 +-
 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h |    2 -
 arch/arm/mach-cns3xxx/include/mach/pm.h      |   21 +++
 arch/arm/mach-cns3xxx/pm.c                   |   21 +++
 drivers/usb/Kconfig                          |    2 +
 drivers/usb/host/Kconfig                     |   15 +++
 drivers/usb/host/ehci-cns3xxx.c              |  176 ++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ohci-cns3xxx.c              |  171 +++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c                  |    5 +
 11 files changed, 468 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/pm.h
 create mode 100644 drivers/usb/host/ehci-cns3xxx.c
 create mode 100644 drivers/usb/host/ohci-cns3xxx.c
