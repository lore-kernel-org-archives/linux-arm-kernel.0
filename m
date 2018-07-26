From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:14 +0100
Subject: [PATCH v2 00/18] arm64: dts: allwinner: A64 boards DT updates
Message-ID: <20180726003532.18751-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

compared to v1, this adds Samuel's Orange Pi Win series in a split-up
form, fixes some issues with the Olinuxino and addresses the other
comments on the list.
The first 12 patches should be fine. I would be grateful for Tested-by's
on the other six patches.

-----------------------------------------
While starring at some DTs while copying the kernel DTs into the U-Boot
tree, I realised that some boards seem to get more love than others.
Fix up some issues I found by inspection on some boards:
Patch 1 adds L2 cache nodes, to avoid a message on the boot console.
Patch 2 adds a separate DT file for the Pine64-LTS board, which from the
software point of view is very much a SOPine + baseboard.
Patch 3 till 11 fix various Orange Pi Win issues, which Samuel posted
before [1]. According to Maxime's comment and with Samuel's permission,
I split them up and integrated them here.
There were reports from people about the Olinuxino board having issues,
so patches 12-14 attempt to fix them.
The NanoPi-A64 also hasn't been updated in a while: enable the Ethernet
and the WiFi/Bluetooth chip, fix a voltage issue and add the LED in the
last four patches.

I don't have the OrangePi, Olinuxino or NanoPi-A64, so can't test these
boards. So even though I have carefully checked the changes against the
available schematics, I would really love to see some testing and
confirmation from owners of these systems.

Cheers,
Andre.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576897.html

Changelog v1..v2:
- add Samuel's Orange Pi Win series (split up)
- add Martin's Tested-by: for the DRAM voltage fix
- add supply property and alias for Olinuxino Ethernet
- fix Olinuxino USB supply issues (AXP VBus, id_det GPIO, bus 0/1 mix-up)
- drop NanoPi-A64 PortE voltage change (clashes with CSI pins)
- fix NanoPi-A64 WiFi node (better node name, no compatible string)

Andre Przywara (9):
  arm64: dts: allwinner: a64: Add L2 cache nodes
  arm64: dts: allwinner: a64: Add Pine64-LTS device tree file
  arm64: dts: allwinner: a64: Olinuxino: fix DRAM voltage
  arm64: dts: allwinner: a64: Olinuxino: add Ethernet nodes
  arm64: dts: allwinner: a64: Olinuxino: enable USB
  arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
  arm64: dts: allwinner: a64: NanoPi-A64: Add Ethernet
  arm64: dts: allwinner: a64: NanoPi-A64: Add Wifi/Bluetooth chip
  arm64: dts: allwinner: a64: NanoPi-A64: Add blue status LED

Samuel Holland (9):
  arm64: dts: allwinner: a64: Orange Pi Win: Fix SD card node
  arm64: dts: allwinner: a64: Orange Pi Win: Fix USB
  arm64: dts: allwinner: a64: Orange Pi Win: Add Ethernet node
  arm64: dts: allwinner: a64: Orange Pi Win: Add UARTs
  arm64: dts: allwinner: a64: Orange Pi Win: Add LED node
  arm64: dts: allwinner: a64: Orange Pi Win: Add SDIO node
  arm64: dts: allwinner: a64: Orange Pi Win: Add SPI flash node
  arm64: dts: allwinner: a64: Orange Pi Win: Mark CPU supply regulator
  arm64: dts: allwinner: a64: Orange Pi Win: Add missing power rails

 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  63 ++++++++-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  70 +++++++++-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 141 ++++++++++++++++++++-
 .../boot/dts/allwinner/sun50i-a64-pine64-lts.dts   |  13 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   9 ++
 6 files changed, 285 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts

-- 
2.14.4
