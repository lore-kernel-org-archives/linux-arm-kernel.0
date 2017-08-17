From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 17 Aug 2017 10:14:20 +0200
Subject: [PATCH v2 0/3] Workaround for bus reset on Cavium cn8xxx root ports
Message-ID: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've picked this up from David, keeping his patches but preventing to
probe vfio-pci devices that can't be reset. 

Without this series starting qemu with a vfio-pci enabled device
can lead to a kernel panic on Cavium systems, depending on the used
hardware.

Changes to v1 (https://lkml.org/lkml/2017/5/15/934):
- Prevent probing by vfio-pci

David Daney (2):
  PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
  PCI: Avoid bus reset for Cavium cn8xxx root ports

Jan Glauber (1):
  vfio/pci: Don't probe devices that can't be reset

 drivers/pci/pci.c           | 4 ++++
 drivers/pci/quirks.c        | 8 ++++++++
 drivers/vfio/pci/vfio_pci.c | 6 ++++++
 3 files changed, 18 insertions(+)

-- 
2.9.0.rc0.21.g7777322
