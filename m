From: jglauber@cavium.com (Jan Glauber)
Date: Fri,  8 Sep 2017 10:10:30 +0200
Subject: [PATCH v4 0/3] Workaround for bus/slot reset on Cavium cn8xxx root
 ports
Message-ID: <20170908081033.3025-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using vfio-pci on a combination of cn8xxx and some PCI devices results in
a kernel panic. This is triggered by issuing a bus or a slot reset
on the PCI device.

With this series both checks indicate that the reset is not possible
preventing the kernel panic.

David Daney (2):
  PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
  PCI: Avoid bus reset for Cavium cn8xxx root ports

Jan Glauber (1):
  PCI: Avoid slot reset if bus reset is not possible

 drivers/pci/pci.c    | 8 ++++++++
 drivers/pci/quirks.c | 8 ++++++++
 2 files changed, 16 insertions(+)

-- 
2.9.0.rc0.21.g7777322
