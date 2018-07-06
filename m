From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 Jul 2018 09:52:00 +0100
Subject: [PATCH 00/10] arm64: dts: allwinner: A64 boards DT updates
Message-ID: <20180706085210.17952-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When starring at some DTs while copying the kernel DTs into the U-Boot
tree, I realised that some boards seem to get more love than others.
Fix up some issues I found by inspection on some boards:
Patch 1 adds L2 cache nodes, to avoid a message on the boot console.
Patch 2 adds a separate DT file for the Pine64-LTS board, which from the
software point of view is very much a SOPine + baseboard.
There were reports from people with the Olinuxino board about various
issues and missing features, so patches 3 till 5 attempt to fix these.
The NanoPi-A64 also hasn't been updated in a while, enable the Ethernet
and the WiFi/Bluetooth chip, and fix some voltage issues in the last 5
patches.

I don't have the Olinuxino or NanoPi-A64, so can't test these boards.
So even though I have carefully checked the changes against the
available schematics, I would treat the patches for those two boards
as a "discussion base" and would love to see some testing and
confirmation from owners of these systems.

Cheers,
Andre.

Andre Przywara (10):
  arm64: dts: allwinner: a64: Add L2 cache nodes
  arm64: dts: allwinner: a64: Add Pine64-LTS device tree file
  arm64: dts: allwinner: a64: Olinuxino: fix DRAM voltage
  arm64: dts: allwinner: a64: Olinuxino: add Ethernet nodes
  arm64: dts: allwinner: a64: Olinuxino: enable USB
  arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
  arm64: dts: allwinner: a64: NanoPi-A64: Add Ethernet
  arm64: dts: allwinner: a64: NanoPi-A64: Fix PortE voltage
  arm64: dts: allwinner: a64: NanoPi-A64: Add Wifi/Bluetooth chip
  arm64: dts: allwinner: a64: NanoPi-A64: Add blue status LED

 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 72 +++++++++++++++++++++-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 63 +++++++++++++++++--
 .../boot/dts/allwinner/sun50i-a64-pine64-lts.dts   | 13 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  9 +++
 5 files changed, 151 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts

-- 
2.14.4
