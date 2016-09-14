From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 17:31:44 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.9 (#2)
Message-ID: <87eg4mbiqn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.9.

As seen yesterday I submit the late pull requests today. It is mainly
for the convert of the Netgear WNR854T to devicetree. I needed to split
the original commits to apply them on the usual branches we use.

Gregory

The following changes since commit a305cc2fce217510dd255356d783e2c01cbc3a8f:

  ARM: dts: mvebu: fix reference to a390 spi controller (2016-08-29 11:26:11 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.9-2

for you to fetch changes up to d30363364811e956816cb586936269ecb9a30299:

  ARM: dts: orion5x: Configure WNR854T ethernet PHY LEDs (2016-09-14 17:00:26 +0200)

----------------------------------------------------------------
mvebu dt for 4.9 (part 2)

- convert orion5x based SoC Netgear WNR854T to devicetree
- remove obsolete orion-gpio binding description

----------------------------------------------------------------
Baruch Siach (1):
      dt-binding: mrvl-gpio: remove orion-gpio description

Jamie Lentin (5):
      ARM: dts: orion5x: Add required properties for orion-wdt to DT node
      dt-bindings: arm: add DT binding for Marvell Orion5x SoC family
      ARM: dts: arm: orion5x: Add DT include for mv88f5181
      ARM: dts: orion5x: Add description for Netgear WNR854T
      ARM: dts: orion5x: Configure WNR854T ethernet PHY LEDs

 .../bindings/arm/marvell/marvell,orion5x.txt       |  25 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |  23 --
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi           |  49 ++++
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      | 251 +++++++++++++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     |   3 +-
 6 files changed, 328 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5181.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
