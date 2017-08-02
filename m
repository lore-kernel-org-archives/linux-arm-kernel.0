From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Aug 2017 16:32:30 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.14 (#1)
Message-ID: <87efsu9h1d.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.14.

There is nothing special in this PR except the fact that it depends on
the mvebu-fixes-4.13-2 tag. Actually it only depends on the "arm64:
dts: marvell: use ICU for the CP110 slave RTC" commit. But I though
that providing a stable tag which will be already in your tree as a
reference would be easier for you.

If you want that I modify it, just tell me.

Thanks,

Gregory

The following changes since commit d7a65c4905bc9c304ecf3d8aa566802f6119480f:

  ARM64: dts: marvell: armada-37xx: Fix the number of GPIO on south bridge (2017-08-02 16:00:00 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.14-1

for you to fetch changes up to 249112cef2f323354be61a27be1d6e94507f7587:

  arm64: dts: marvell: re-order RTC nodes in Marvell CP110 description (2017-08-02 16:07:38 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.14 (part 1)

For Armada 37xx:
- GIC improvement
- Add PMUv3
- Enable USB2 on EspressoBin

For Armada 7K/8K:
- add GPIO interrupts for CP110
- add pinctrl nodes to describe the CPM I2C0 and CPS SPI1
- re-order RTC nodes in Marvell CP110 description
- on MacchiatoBin
    - fix USB3 regulator definition
    - add support for i2c mux
    - add support for PCIe
    - add an stdout-path

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: dts: marvell: mcbin: add an stdout-path

Marc Zyngier (4):
      ARM64: dts: marvell: armada-37xx: Fix GIC maintenance interrupt
      ARM64: dts: marvell: armada-37xx: Enable memory-mapped GIC CPU interface
      ARM64: dts: marvell: armada-37xx: Wire PMUv3
      ARM64: dts: marvell: armada-37xx: Enable USB2 on espressobin

Russell King (5):
      arm64: dts: marvell: cp110: add GPIO interrupts
      arm64: dts: marvell: mcbin: add pinctrl nodes
      arm64: dts: marvell: fix USB3 regulator definition on MacchiatoBin
      arm64: dts: marvell: mcbin: add support for i2c mux
      arm64: dts: marvell: mcbin: add support for PCIe

Thomas Petazzoni (1):
      arm64: dts: marvell: re-order RTC nodes in Marvell CP110 description

 .../boot/dts/marvell/armada-3720-espressobin.dts   |  5 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 11 ++-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 94 +++++++++++++++++++++-
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 25 ++++--
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 25 ++++--
 5 files changed, 141 insertions(+), 19 deletions(-)
