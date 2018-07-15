From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 15 Jul 2018 19:00:21 +0300
Subject: [PATCH 0/8] Fix PCI I/O space page leaks
Message-ID: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's a set of 8 patches against the 'pci/controller-fixes' branch of Lorenzo
Pieralisi's 'pci.git' repo. They are the fixes for the PCI I/O space page leaks
(and the kernel BUG caused by them on deferred probe); those were 1st found
testing the R-Car PCIe driver. The patches are in the chronological order
(considering the date/time of the commits specified in the Fixes: tag), patches
#2..#8 depend on the patch #1 in order to build/work as it introduces the managed
device API that they all use...

[1/8] PCI: xgene: Fix I/O space page leak
[2/8] PCI: of: Fix I/O space page leak
[3/8] PCI: versatile: Fix I/O space page leak
[4/8] PCI: designware: Fix I/O space page leak
[5/8] PCI: aardvark: Fix I/O space page leak
[6/8] PCI: faraday: Fix I/O space page leak
[7/8] PCI: mediatek: Fix I/O space page leak
[8/8] PCI: v3-semi: Fix I/O space page leak

MBR, Sergei
