From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Mar 2018 18:15:39 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.17 (#1)
Message-ID: <87lgf12mro.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.17.

Gregory

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.17-1

for you to fetch changes up to 597667d889517c6085d57aac92dbf1cc624cd8ae:

  ARM64: dts: marvell: armada-cp110: Add apb_pclk clock for the uart nodes (2018-03-09 17:49:46 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.17 (part 1)

- convert to the SPDX-License-Identifier
- add missing clocks (for the registers) on some of the peripherals
- use the new nand driver
- add more uart for Armada 7K/8K SoCs

----------------------------------------------------------------
Baruch Siach (3):
      arm64: dts: marvell: add CP110 uart peripherals
      arm64: dts: marvell: mcbin: enable uart headers
      arm64: dts: marvell: mcbin: fix board name typo

Gregory CLEMENT (11):
      ARM64: dts: marvell: armada-cp110: Add registers clock for SPI nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for I2C nodes
      arm64: dts: marvell: use SPDX-License-Identifier for Armada SoCs
      arm64: dts: marvell: armada-3720-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-3720-espressobin: use SPDX-License-Identifier
      arm64: dts: marvell: armada-7040-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8040-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8040-mcbin: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8080-db: use SPDX-License-Identifier
      ARM64: dts: marvell: armada-cp110: Add registers clock for sata node
      ARM64: dts: marvell: armada-cp110: Add apb_pclk clock for the uart nodes

Miquel Raynal (2):
      arm64: dts: marvell: use reworked NAND controller driver on Armada 7K
      arm64: dts: marvell: use reworked NAND controller driver on Armada 8K

 arch/arm64/boot/dts/marvell/armada-371x.dtsi       | 38 +--------
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 39 +--------
 .../boot/dts/marvell/armada-3720-espressobin.dts   | 38 +--------
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       | 38 +--------
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 38 +--------
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 93 ++++++++--------------
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 87 +++++++-------------
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 65 ++++++---------
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     | 41 +---------
 arch/arm64/boot/dts/marvell/armada-8080.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       | 41 +---------
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 41 +---------
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 41 +---------
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 41 +---------
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 41 +---------
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 41 +---------
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |  2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 81 ++++++++++++++++---
 23 files changed, 172 insertions(+), 880 deletions(-)
