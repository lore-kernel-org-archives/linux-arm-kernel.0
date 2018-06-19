From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 19 Jun 2018 14:43:59 +0200
Subject: [PATCH 0/3] cpufreq: add AVS support for Armada 3700
Message-ID: <20180619124402.902-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Armada 37xx supports also Adaptive Voltage Scaling and this series
allow to us it.

In order to configure it, the drives needs to access a new set of
register which is documented in patch 1 and added in the dts in patch
3.

the first 2 patches should be merged through the cpufreq subsystem,
and I will take care of the 3rd patch once the binding will have been
validated.

Thanks,

Gregory CLEMENT (3):
  dt-bindings: marvell: Add documentation for the Armada 3700 AVS
    binding
  cpufreq: armada-37xx: Add AVS support
  arm64: dts: marvell: armada-37xx: add the node allowing AVS support

 .../bindings/arm/marvell/armada-37xx.txt      |  16 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   6 +
 drivers/cpufreq/armada-37xx-cpufreq.c         | 163 +++++++++++++++++-
 3 files changed, 182 insertions(+), 3 deletions(-)

-- 
2.17.1
