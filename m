From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:05 +0200
Subject: [PATCH 0/9] arm64: marvell: 7k/8k: improve network support
Message-ID: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series improves the network support on Marvell 7k and 8k platforms
by adding descriptions of the comphy, and by using the comphy in already
available networking ports. The series also introduces a description of
the SFP ports on the Marvell Armada 7040-db and 8040-db.

Two defconfig patches also improve the Marvell ARM64 support by enabling
required options allowing to use the networking ports properly.

This series follows recent improvements in the PPv2 driver.

Based on v4.14-rc1, and tested on the Marvell Armada 7040-db, 8040-db
and 8040-mcbin.

Thanks!
Antoine

Antoine Tenart (8):
  arm64: defconfig: enable the Marvell 10G PHY as a module
  arm64: dts: marvell: extend the cp110 syscon register area length
  arm64: dts: marvell: add comphy nodes on cp110 master and slave
  arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
  arm64: dts: marvell: 7040-db: add comphy reference to Ethernet port
  arm64: dts: marvell: cp110: add PPv2 port interrupts
  arm64: dts: marvell: 7040-db: enable the SFP port
  arm64: dts: marvell: 8040-db: enable the SFP ports

Miquel Raynal (1):
  arm64: defconfig: enable Marvell CP110 comphy

 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  7 +++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 10 ++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  3 ++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 55 +++++++++++++++++++---
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 55 +++++++++++++++++++---
 arch/arm64/configs/defconfig                       |  2 +
 6 files changed, 118 insertions(+), 14 deletions(-)

-- 
2.13.5
