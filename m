From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Sep 2014 09:46:41 +0200
Subject: [PATCH v2 0/4] arm64, thunder: Enable Cavium Thunder SoC Family
Message-ID: <1409903205-2762-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This initial patches enable Cavium Thunder SoC Family. The patches add
Kconfig and devicetree support and then add Thunder to the defconfig.

The Thunder system needs more enablement patches for subsystems and
devices, this includes network, ahci, gicv3/gicv3-its, pci, smmu, kvm.
We will send separate patch sets for these. All of them base on this
initial patches.

I sent a separate patch set independently that introduces support for
dts vendor subdirs. After both patch sets have been applied I will
send a patch in addition that moves the dts file into a subdirectory.

Patches are available here:

 git://git.kernel.org/pub/scm/linux/kernel/git/rric/linux.git thunder/init

v2 changes:
* rebased to 3.17
* placed commas between 32-bit portions of 64 bit addresses
* removed #address-cells and size-cells in gic node
* get rid of the clocks node
* changed to gpl/x11 dual license
* removed memreserve
* moved gic to bus node

Radha Mohan Chintakuntla (3):
  arm64, thunder: Add Kconfig option for Cavium Thunder SoC Family
  arm64, thunder: Add initial dts for Cavium Thunder SoC
  arm64, thunder: Document devicetree bindings for Cavium Thunder SoC

Robert Richter (1):
  arm64, defconfig: Enable Cavium Thunder SoC in defconfig

 .../devicetree/bindings/arm/cavium-thunder.txt     |  10 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/thunder-88xx.dts               | 414 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 6 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
 create mode 100644 arch/arm64/boot/dts/thunder-88xx.dts

-- 
2.0.1
