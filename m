From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Sep 2016 17:58:41 -0500
Subject: [PATCH 0/5] Use mmio-sram driver for Keystone MSMC RAM
Message-ID: <20160901225846.31058-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Keystone 2 family of SoCs have an on-chip RAM called the
Multicore Shared Memory (MSM) RAM. This RAM is accessible through
the Multicore Shared Memory Controller (MSMC). This series represents
these on-chip RAMs as sram nodes so that the memory allocations
can be managed by the in-kernel mmio-sram driver.

The first 4 patches adds the basic SRAM nodes on each of the SoCs,
and the last patch enables the generic on-chip SRAM driver for
keystone defconfig.

regards
Suman


Suman Anna (5):
  ARM: dts: keystone-k2hk: Add MSM RAM node
  ARM: dts: keystone-k2l: Add MSM RAM node
  ARM: dts: keystone-k2e: Add MSM RAM node
  ARM: dts: keystone-k2g: Add MSM RAM node
  ARM: configs: keystone: Enable Generic on-chip SRAM driver

 arch/arm/boot/dts/keystone-k2e.dtsi  | 8 ++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi  | 8 ++++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi | 8 ++++++++
 arch/arm/boot/dts/keystone-k2l.dtsi  | 8 ++++++++
 arch/arm/configs/keystone_defconfig  | 1 +
 5 files changed, 33 insertions(+)

-- 
2.9.3
