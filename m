From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:28:49 +0800
Subject: [PATCH 0/3] Add ethernet0 alias for several A64 boards
Message-ID: <20170722022852.7868-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC has an EMAC which is used to provide Ethernet
function on several boards.

The EMAC itself doesn't have a fixed MAC address, but the sunxi
mainline U-Boot have the ability to generate one based on the eFUSE
SID in the chip, and add the generated MAC address to the device
tree when booting.

The MAC address setting step is based on the device tree's aliases,
and device tree nodes prefixed "ethernet" will get the MAC address
added. However, in several A64 boards' device tree, the alias is not
set up, so that the U-Boot won't set the MAC address.

Add the ethernet0 aliases to these boards.

I hope this patchset can be queued in 4.13, otherwise 4.13 kernels
won't get non-volatile MAC addresses, and will use random ones
instead, which is annoying to many users.

Icenowy Zheng (3):
  arm64: allwinner: a64: add ethernet0 alias for BPi M64 EMAC node
  arm64: allwinner: a64: add ethernet0 alias for Pine64 EMAC node
  arm64: allwinner: a64: add ethernet0 alias for SoPine EMAC node

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 1 +
 3 files changed, 3 insertions(+)

-- 
2.13.0
