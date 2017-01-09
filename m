From: s-anna@ti.com (Suman Anna)
Date: Mon, 9 Jan 2017 13:43:53 -0600
Subject: [PATCH 0/5] Reset Controller Nodes for TI Keystone platforms
Message-ID: <20170109194358.27271-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

This patch adds the reset controller nodes and the corresponding
reset data for TI Keystone 66AK2H, 66AK2L and 66AK2E SoCs. These
resets are for the DSPs on these SoCs, and are the last dependencies
before the keystone remoteproc driver can be added.

All these SoCs will use the ti-syscon-reset driver which is already
part of mainline kernel. The bindings for the same can be found in
Documentation/devicetree/bindings/reset/ti-syscon-reset.txt file.
Note that the other Keystone 66AK2G SoC will use a different TI-SCI
based reset driver, so will be submitted separately once the TI-SCI
dependencies make it into mainline.

Patches are based on top of 4.10-rc1 plus the MSM-RAM DT node series
that you have already picked up. Patch 1 enable the Reset Framework
for Keystone platforms, and remaining patches add the required DT
nodes.

regards
Suman


Suman Anna (5):
  ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER
  ARM: dts: keystone: Add PSC node
  ARM: dts: keystone-k2hk: Add PSC reset controller node
  ARM: dts: keystone-k2l: Add PSC reset controller node
  ARM: dts: keystone-k2e: Add PSC reset controller node

 arch/arm/boot/dts/keystone-k2e.dtsi  | 13 +++++++++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2l.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi      |  5 +++++
 arch/arm/mach-keystone/Kconfig       |  1 +
 5 files changed, 55 insertions(+)

-- 
2.10.2
