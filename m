From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 25 Jul 2011 17:09:57 +0100
Subject: [PATCH 0/3] Add device tree based initialisation for VIC
Message-ID: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to allow VIC devices to be probed from the device tree.
Currently the only in-tree device tree enabled user of the VIC is versatile,
but I'll shortly submit patches for picoxcell on device tree that uses 2
VIC's.

I've split this into 3 patches for bisectability, but this could be fairly
squashed into 2.

Jamie Iles (3):
  vic: add device tree bindings
  versatile dt: set the irq-start property for the vic
  versatile: convert to common VIC DT probing

 Documentation/devicetree/bindings/arm/vic.txt |   21 +++++++++++++++
 arch/arm/boot/dts/versatile-ab.dts            |    1 +
 arch/arm/common/vic.c                         |   35 +++++++++++++++++++++++++
 arch/arm/include/asm/hardware/vic.h           |    5 +++
 arch/arm/mach-versatile/core.c                |    9 +-----
 5 files changed, 63 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt

-- 
1.7.4.1
