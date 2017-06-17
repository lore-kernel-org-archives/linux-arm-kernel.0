From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 17 Jun 2017 08:47:25 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#1)
Message-ID: <87poe35cw2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.13.

Gregory

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.13-1

for you to fetch changes up to f66b2aff46eaf0825dbe1560e28fcb845dd2a215:

  arm64: dts: marvell: add xmdio nodes for 7k/8k (2017-06-17 08:19:29 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.13 (part 1)

- Improve the mcbin support (Armada 8040 based board): add sdhci and
  the second 1G port
- Improve crypro nodes description on Aramda 7K/8K
- Use new binding for ap806 clocks
- Improve mdio nodes and add xmdio on Aramda 7K/8K
- Add second SGCI node on Armada 37xx
- Improve the description of the Armada 3720 DB board

----------------------------------------------------------------
Antoine Tenart (7):
      arm64: dts: marvell: add dma-mask in crypto nodes for 7k/8k
      arm64: dts: marvell: explicitly enable the mdio nodes for 7k/8k DB
      arm64: dts: marvell: disable the mdio nodes by default
      arm64: dts: marvell: cp110: enable the crypto engine at the SoC level
      arm64: dts: marvell: remove cpm crypto nodes from dts files
      arm64: dts: marvell: add a comment on the cp110 slave node status
      arm64: dts: marvell: add xmdio nodes for 7k/8k

Gregory CLEMENT (7):
      arm64: dts: marvell: remove clock-output-names on ap806
      arm64: dts: marvell: use new binding for the system controller on ap806
      arm64: dts: marvell: armada-3720-db: Sort the dts node alphabetically
      arm64: dts: marvell: armada-3720-db: Add information about the V2 board
      arm64: dts: marvell: armada-37xx: Align the compatible string
      arm64: dts: marvell: armada-37xx: Use angle bracket for each register set
      arm64: dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot

Konstantin Porotchkin (1):
      arm64: dts: marvell: Enable second SDHCI controller in Armada 37xx

Marc Zyngier (1):
      arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet

Marcin Wojtas (1):
      arm64: dts: marvell: add second 1G port on the Armada 8040 DB

Russell King (2):
      arm64: dts: marvell: mcbin: add sdhci
      arm64: dts: marvell: cp110: add required clocks for mdio interface

Thomas Petazzoni (1):
      arm64: dts: marvell: add clocks for Armada AP806 XOR engines

 arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 120 +++++++++++++--------
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  25 +++--
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   6 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  24 ++++-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  40 +++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  27 ++---
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  12 ++-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  18 ++++
 8 files changed, 200 insertions(+), 72 deletions(-)
