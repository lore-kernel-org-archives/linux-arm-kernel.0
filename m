From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:32 +0100
Subject: [PATCH 0/5] ARM64: dts: marvell: armada37xx: DT fixes and enablements
Message-ID: <20170701141637.24719-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I finally got a chance to spend some time with an Armada-3720-based
Espressobin, and immediately faced a number of issues which would make
the system of limited use for me. Fortunately, these are pretty easy
to fix:

- The first patch (already posted a couple of weeks ago, and included
  here for completeness) fixes what is probably a copy-paste issue
  between GICv2 and GICv3-based platforms, where a cpu-mask is wrongly
  applied to PPIs.

- The following two patches add missing properties that are required
  for enabling virtualisation support (GIC maintenance interrupt, MMIO
  regions for GICv2 guest compatibility). KVM now runs correctly on
  this HW.

- The following patch exposes the CPUs' PMUv3, making perf work. Hey,
  for once it is wired correctly, without anything funky breaking the
  interrupt routing! Let's not miss this once in a lifetime
  opportunity!

- The last patch enables the USB2 interface on the Espressobin. OK,
  not very useful, but since it works...

This has been tested on -next as of this yesterday.

	M.

Marc Zyngier (5):
  ARM64: dts: marvell: armada37xx: Fix timer interrupt specifiers
  ARM64: dts: marvell: armada37xx: Fix GIC maintenance interrupt
  ARM64: dts: marvell: armada37xx: Enable memory-mapped GIC CPU
    interface
  ARM64: dts: marvell: armada37xx: Wire PMUv3
  ARM64: dts: marvell: armada37xx: Enable USB2 on espressobin

 .../boot/dts/marvell/armada-3720-espressobin.dts   |  5 +++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 23 +++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.11.0
