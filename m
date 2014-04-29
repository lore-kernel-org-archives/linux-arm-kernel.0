From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Apr 2014 09:11:01 -0400
Subject: [GIT PULL] ARM: mvebu: pci/mbus fixes for v3.15
Message-ID: <20140429131101.GI28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-soc guys,

This rather large (for fixes) changeset resolves multiple problems with
the mvebu PCIe driver.  While it works fine for simple use cases, more
complicated uses highlighted multiple problems with MSI handling and mbus
window creation.

These changes are Acked by the appropriate maintainers and have been in
-next for about a week.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-mbus_pci-fixes-3.15

for you to fetch changes up to 398f5d5e10b6b917cd9d35ef21d545b0afbada22:

  PCI: mvebu: split PCIe BARs into multiple MBus windows when needed (2014-04-24 03:48:41 +0000)

----------------------------------------------------------------
mvebu drivers (mbus and pci) fixes for v3.15

 - pci

    - fix off-by-one for mbus window size
    - split BARs into multiple mbus windows when needed

 - mbus

    - avoid setting undefined window size
    - allow several windows with the same target/attr

----------------------------------------------------------------
Jason Gunthorpe (1):
      bus: mvebu-mbus: Avoid setting an undefined window size

Thomas Petazzoni (2):
      bus: mvebu-mbus: allow several windows with the same target/attribute
      PCI: mvebu: split PCIe BARs into multiple MBus windows when needed

Willy Tarreau (1):
      PCI: mvebu: fix off-by-one in the computed size of the mbus windows

 drivers/bus/mvebu-mbus.c     | 22 ++++++++---
 drivers/pci/host/pci-mvebu.c | 92 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 92 insertions(+), 22 deletions(-)
