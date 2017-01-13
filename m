From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Jan 2017 18:11:47 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#1)
Message-ID: <87ziiu7ulo.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.11.

Gregory

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.11-1

for you to fetch changes up to 7b7db5ab33d2292d9b037cda0c41a795b094d940:

  ARM: dts: turris-omnia: add support for ethernet switch (2017-01-05 13:59:18 +0100)

----------------------------------------------------------------
mvebu dt for 4.11 (part 1)

- Add support for the ethernet switch on the Turris Omnia board
- Clean up and improvement for ClearFog boards
- Correct license text which was mangled when switching to dual license

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: mvebu: Correct license text

Russell King (14):
      ARM: dts: armada388-clearfog: fix SPI flash #size-cells
      ARM: dts: armada388-clearfog: move SPI flash into microsom
      ARM: dts: armada388-clearfog: move sdhci pinctrl node to microsom
      ARM: dts: armada388-clearfog: split clearfog DTS file
      ARM: dts: armada388-clearfog: move DSA switch
      ARM: dts: armada388-clearfog: move second PCIe port
      ARM: dts: armada388-clearfog: move SPI CS1
      ARM: dts: armada388-clearfog: move rear button
      ARM: dts: armada388-clearfog: add base model DTS file
      ARM: dts: armada388-clearfog: add pro model DTS file
      ARM: dts: armada388-clearfog: move device specific pinctrl nodes
      ARM: dts: armada388-clearfog: move I2C nodes
      ARM: dts: armada388-clearfog: move ethernet related nodes
      ARM: dts: armada388-clearfog: move uart nodes

Uwe Kleine-K?nig (1):
      ARM: dts: turris-omnia: add support for ethernet switch

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-db.dts                |  10 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  10 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  10 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  10 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  10 +-
 arch/arm/boot/dts/armada-370-rd.dts                |  10 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  10 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  10 +-
 arch/arm/boot/dts/armada-370.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-375-db.dts                |  10 +-
 arch/arm/boot/dts/armada-375.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-380.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |  58 +++-
 arch/arm/boot/dts/armada-385.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-388-clearfog-base.dts     | 109 ++++++
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      |  55 +++
 arch/arm/boot/dts/armada-388-clearfog.dts          | 374 ++++-----------------
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 307 +++++++++++++++++
 arch/arm/boot/dts/armada-388-db.dts                |  10 +-
 arch/arm/boot/dts/armada-388-rd.dts                |  10 +-
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 130 ++++---
 arch/arm/boot/dts/armada-38x.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-390-db.dts                |  10 +-
 arch/arm/boot/dts/armada-390.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-395.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-398-db.dts                |  10 +-
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  10 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |  10 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |  10 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  10 +-
 arch/arm/boot/dts/armada-xp-matrix.dts             |  10 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  10 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  10 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  10 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +-
 arch/arm/boot/dts/dove-cm-a510.dtsi                |  10 +-
 arch/arm/boot/dts/dove-sbc-a510.dts                |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   |  10 +-
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  10 +-
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |  10 +-
 .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    |  10 +-
 arch/arm/boot/dts/orion5x-kuroboxpro.dts           |  10 +-
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |  10 +-
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   |  10 +-
 arch/arm/boot/dts/orion5x-linkstation.dtsi         |  10 +-
 arch/arm/boot/dts/orion5x-lschl.dts                |  10 +-
 arch/arm/boot/dts/orion5x-lswsgl.dts               |  10 +-
 59 files changed, 933 insertions(+), 622 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-base.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-pro.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog.dtsi
