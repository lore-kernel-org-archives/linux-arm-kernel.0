From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 17 Jun 2017 08:47:07 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.13 (#1)
Message-ID: <87r2yj5cwk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.13.

Gregory

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.13-1

for you to fetch changes up to 97800cf8b6a81cf17ad216ec9d0c8e78c68b7aef:

  ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM (2017-06-17 08:16:46 +0200)

----------------------------------------------------------------
mvebu dt for 4.13 (part 1)

- Add Linksys WRT3200ACM (Rango) support
- Add PWM properties for gpio on Aramda XP and 38x
- A couple of minor updates for the 98dx3236 and 98dx4251

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: dts: mvebu: Add PWM properties to .dtsi files
      ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan

Chris Packham (2):
      ARM: dts: mvebu: add missing interrupt to 98dx4251 switch
      ARM: dts: mvebu: disable the rtc on 98dx3236 SoC

Javier Martinez Canillas (1):
      ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM

Ralph Sennhauser (13):
      ARM: dts: mvebu: Add PWM properties for armada-38x
      ARM: dts: armada-385-linksys: flatten dtsi
      ARM: dts: armada-385-linksys: label nodes
      ARM: dts: armada-385-linksys: flatten dependants
      ARM: dts: armada-385-linksys: drop redundant properties in dependants
      ARM: dts: armada-385-linksys: bm pools by label order
      ARM: dts: armada-385-linksys: usb3 label cleanup
      ARM: dts: armada-385-linksys: drop legacy DSA bindings
      ARM: dts: armada-385-linksys: use binary unit prefixes
      ARM: dts: armada-385-linksys: partition layout is board specific
      ARM: dts: armada-385-linksys: group pins in pinctrl
      ARM: dts: armada-385-linksys: fixup button node names
      ARM: dts: mvebu: add support for Linksys WRT3200ACM (Rango)

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/armada-370.dtsi               |  19 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 187 +++++++-----
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 187 +++++++-----
 arch/arm/boot/dts/armada-385-linksys-rango.dts  | 203 +++++++++++++
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 187 +++++++-----
 arch/arm/boot/dts/armada-385-linksys.dtsi       | 362 ++++++++----------------
 arch/arm/boot/dts/armada-385-turris-omnia.dts   |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi               |  16 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       |   4 +
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi       |   1 +
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts   |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi        |  16 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi        |  19 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi        |  19 +-
 15 files changed, 768 insertions(+), 463 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts
