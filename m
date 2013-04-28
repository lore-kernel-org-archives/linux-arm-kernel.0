From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 28 Apr 2013 15:16:42 +1200
Subject: [PATCH 0/4] Add support for velocity network driver on platform
 devices
Message-ID: <1367119006-31280-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first three patches are general tidyup.
Patch #1 just alphabetizes the #includes to make it easier to read.
Patch #2 replaces vptr->dev with vptr->netdev, again for clarity in the code.
Patch #3 replaces the pci dma functions with the generic versions.

I have build tested these patches but don't have a PCI velocity to run-test it.
I can't see that they should introduce any problems as it is all renames and
function swapping.

Patch #4 adds support for the velocity driver on devicetree platform devices.
Binding document included. This patch is compile-tested for PCI, and boot
tested on a VIA APC8750.

I think it would be pertinent to get some tested-by's for PCI users.

Regards
Tony Prisk


Tony Prisk (4):
  net: velocity: Alphabetize #includes
  net: velocity: Rename vptr->dev to vptr->netdev
  net: velocity: Convert to generic dma functions
  net: velocity: Add platform device support to VIA velocity driver

 .../devicetree/bindings/net/via-velocity.txt       |   20 +
 drivers/net/ethernet/via/Kconfig                   |    3 +-
 drivers/net/ethernet/via/via-velocity.c            |  612 ++++++++++++++------
 drivers/net/ethernet/via/via-velocity.h            |   35 +-
 4 files changed, 480 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/via-velocity.txt

-- 
1.7.9.5
