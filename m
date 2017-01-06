From: s-anna@ti.com (Suman Anna)
Date: Fri, 6 Jan 2017 15:57:24 -0600
Subject: [PATCH v2 0/9] Use mmio-sram driver for Keystone MSMC RAM
Message-ID: <20170106215733.41637-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Keystone 2 family of SoCs have an on-chip RAM called the
Multicore Shared Memory (MSM) RAM. This RAM is accessible through
the Multicore Shared Memory Controller (MSMC). This series represents
these on-chip RAMs as sram nodes so that the memory allocations
can be managed by the in-kernel mmio-sram driver.

This is v2 of the previous series [1], and now includes 4 additional
patches that reserve the portions of the MSMC RAM used by the
Keystone Boot Monitor. The first 5 patches are essentially the same
as in v1, with minor commit description updates for using the proper
SoC names, but no code changes.

Patches baselined on 4.10-rc1.

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=147277092730387&w=2

Suman Anna (9):
  ARM: dts: keystone-k2hk: Add MSM RAM node
  ARM: dts: keystone-k2l: Add MSM RAM node
  ARM: dts: keystone-k2e: Add MSM RAM node
  ARM: dts: keystone-k2g: Add MSM RAM node
  ARM: configs: keystone: Enable Generic on-chip SRAM driver
  ARM: dts: keystone-k2hk: Reserve MSM RAM for boot monitor
  ARM: dts: keystone-k2l: Reserve MSM RAM for boot monitor
  ARM: dts: keystone-k2e: Reserve MSM RAM for boot monitor
  ARM: dts: keystone-k2g: Reserve MSM RAM for boot monitor

 arch/arm/boot/dts/keystone-k2e.dtsi  | 12 ++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi  | 12 ++++++++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/keystone-k2l.dtsi  | 12 ++++++++++++
 arch/arm/configs/keystone_defconfig  |  1 +
 5 files changed, 49 insertions(+)

-- 
2.10.2
