From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Jun 2017 14:26:30 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#2)
Message-ID: <877f041a4p.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.13.

This came only now because I waited for that the drivers part was
accepted. Now that is was done we can enable the last missing part of
the infrastructure for the Aramda 7K/8K SoCs.

Also note that there is a trivial merge conflict with the mvebu-fixes
branch. In case of doubt it was resolved in the last merge commit of
the mvebu/for-next branch.

Thanks,


Gregory

The following changes since commit f66b2aff46eaf0825dbe1560e28fcb845dd2a215:

  arm64: dts: marvell: add xmdio nodes for 7k/8k (2017-06-17 08:19:29 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.13-2

for you to fetch changes up to 6ef84a827c37547504514a80bdb35f74a67df5a3:

  arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K (2017-06-21 17:09:48 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.13 (part 2)

- use new clock binding for Armada 7K/8K
- add pinctrl on Armada 7K/8K
- add GPIO on Armada 7K/8K
- switch from GIC to ICU on CP110 (Armada 7K/8K)
- enable the mdio node on the mcbin (Armada 8K based board)

----------------------------------------------------------------
Antoine Tenart (2):
      arm64: dts: marvell: mcbin: enable the mdio node
      arm64: dts: marvell: use new bindings for xor clocks on ap806

Gregory CLEMENT (4):
      arm64: dts: marvell: remove *-clock-output-names on cp110
      arm64: dts: marvell: use new binding for the system controller on cp110
      arm64: dts: marvell: add pinctrl support for Armada 7K/8K
      arm64: dts: marvell: add gpio support for Armada 7K/8K

Thomas Petazzoni (1):
      arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  68 +++++++++++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   3 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |   2 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   3 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  76 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  29 ++++-
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 136 ++++++++++++---------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 131 +++++++++++---------
 10 files changed, 329 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-70x0.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-80x0.dtsi
