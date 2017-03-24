From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Mar 2017 18:23:47 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.12 (#1)
Message-ID: <87inmybnbw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.12.

Gregory

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.12-1

for you to fetch changes up to cd2f0d0d403b7eb779fba04ea9664faa3b625cde:

  ARM: dts: mvebu: linksys: enable buffer manager support (2017-03-23 17:29:42 +0100)

----------------------------------------------------------------
mvebu dt for 4.12 (part 1)

- Add node lable for Armada 38x
- Add support for Synology DS116 NAS and Linksys WRT1900ACS
- Update mbus controller description on Armada 38x allowing entering in standby
- Add default trigger for sata led on various linksys boards
- Update newly added armada-xp-98dx3236
- Enable hardware buffer manager support for the devices in the
  Linksys WRT AC Serie

----------------------------------------------------------------
Ansuel Smith (1):
      ARM: dts: armada: Add default trigger for sata led

Chris Packham (5):
      ARM: dts: armada-38x add node labels
      ARM: dts: armada-xp-98dx3236: combine dfx server nodes
      ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236
      ARM: dts: mvebu: Move mv98dx3236 clock bindings
      ARM: dts: mvebu: remove unnecessary PCI range from 98dx3236

Gregory CLEMENT (1):
      ARM: dts: armada-38x: Adjust mbus controller description on Armada 38x

Ralph Sennhauser (2):
      ARM: dts: armada-385: add support for the Linksys WRT1900ACS (Shelby)
      ARM: dts: mvebu: linksys: enable buffer manager support

Willy Tarreau (1):
      ARM: dts: armada-385-synology-ds116: add support for Synology DS116 NAS

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
 .../bindings/clock/mvebu-gated-clock.txt           |  11 +
 .../devicetree/bindings/net/marvell,prestera.txt   |  13 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    |   1 +
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     |   1 +
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 114 ++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi          |  17 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts    | 321 +++++++++++++++++++++
 arch/arm/boot/dts/armada-385.dtsi                  |  20 +-
 arch/arm/boot/dts/armada-388.dtsi                  |   9 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  41 +--
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 211 ++++++++++----
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |   2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  18 +-
 18 files changed, 690 insertions(+), 104 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
 create mode 100644 arch/arm/boot/dts/armada-385-synology-ds116.dts
