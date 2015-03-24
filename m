From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 10:50:28 +0200
Subject: [PATCH 0/2] ALpine: add support for internal pci bus
Message-ID: <55112554.1jdqt7tBRO3rWZMX%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the internal pci bus on the Alpine platform.
On-chip devices appear as pci devices on this bus.

This enables the use of standard drivers and Software to support the 
Alpine-based systems, for example since the SATA devices on the 
chip appear as standard SATA devices, the AHCI driver in the kernel 
can detect and bring-up these SATA devices.

Patch #1 enables the generic-pci device when building alpine.

Patch #2 adds the required device-tree entry.

Tsahee Zidenberg (2):
  ARM: Alpine: add support for generic pci
  ARM: dts: alpine: add internal pci

 arch/arm/boot/dts/alpine.dtsi | 20 ++++++++++++++++++++
 arch/arm/mach-alpine/Kconfig  |  2 ++
 2 files changed, 22 insertions(+)

-- 
1.9.1
