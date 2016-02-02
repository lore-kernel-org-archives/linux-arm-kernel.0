From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue,  2 Feb 2016 17:25:14 -0600
Subject: [PATCH 0/3] Add initial support for TI's K2G SOC
Message-ID: <1454455517-7360-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides initial support for K2G the latest addition to Texas
Instruments Keystone 2 product family. These patches are built on top of
the latest 4.5-rc2 commit.

K2G is a A15 + C66x DSP processor built to address the needs of industrial
communication and control, automotive and performance audio applications.

Supported peripherals include MMC,USB2.0,DCAN,DSS,McASP and PCIe SS.

The technical reference manual for K2G can be found here:
http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf

This patchset provides the ability to boot K2G's general purpose evm using
a ramfs filesystem.

Additional patches will follow this series that will add support for new
drivers that will enable additional peripherals and features

K2G Bootlog on 4.5-rc2:
http://pastebin.ubuntu.com/14861580/

To show no regressions:
K2E Bootlog: http://pastebin.ubuntu.com/14861523/
Other Keystone 2 devices need this partial revert discussed in the below
thread.
http://marc.info/?l=linux-netdev&m=145444838030865&w=2

This is an issue seen on the netcp driver and has nothing to do with this
patch set.

Nishanth Menon (1):
  ARM: keystone: Create new binding for K2G SoC

Vitaly Andrianov (2):
  ARM: dts: keystone: Add Initial DT support for TI K2G SoC family
  ARM: dts: keystone: Add minimum support for K2G evm

 .../devicetree/bindings/arm/keystone/keystone.txt  |  5 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/k2g-evm.dts                      | 32 ++++++++
 arch/arm/boot/dts/k2g.dtsi                         | 89 ++++++++++++++++++++++
 arch/arm/mach-keystone/keystone.c                  |  1 +
 5 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/k2g-evm.dts
 create mode 100644 arch/arm/boot/dts/k2g.dtsi

-- 
2.7.0
