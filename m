From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jul 2016 16:35:54 +0200
Subject: [PATCH 0/2] arm64: marvell: add support for the slave CP in Armada 8K
Message-ID: <1469716556-15299-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following set of two patches add support for the slave CP HW block
found in the Armada 8K SoCs. As a reminder:

 - Armada 7K is an SoC with one AP and one CP. The AP is the part that
   contains the CPU, cache and a few basic I/Os. The CP is the part
   that contains most interesting I/Os (PCIe, SATA, USB, Ethernet,
   etc.)

 - Armada 8K is an SoC with one AP and two CPs.

This set of patches add support for the second CP found in Armada 8K,
also called the "slave CP110".

Thanks,

Thomas

Thomas Petazzoni (2):
  arm64: dts: marvell: add description for the slave CP110 in Armada 8K
  arm64: dts: marvell: add description for the Armada 8040 dev board

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 .../{armada-8020.dtsi => armada-8040-db.dts}       | 109 ++++++++-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 246 +++++++++++++++++++++
 5 files changed, 351 insertions(+), 7 deletions(-)
 copy arch/arm64/boot/dts/marvell/{armada-8020.dtsi => armada-8040-db.dts} (55%)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi

-- 
2.7.4
