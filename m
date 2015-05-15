From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 May 2015 12:54:06 +0200
Subject: [GIT PULL] ARM: berlin: DT changes for v4.2 (round 1)
In-Reply-To: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431687246-31039-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

this is Marvell Berlin SoC DT for v4.2 including:
- GPLv2/X11 dual-licensing of DT files,
- a note about currently unstable DT bindings as we struggle to get
  DT bindings right in the first place with limited documentation available,
- Rework of System/Chip Controller binding documentation and nodes to
  simple-mfd.

Please pull.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-4.2-1

for you to fetch changes up to 3933a23a091662be8a8b63e53b26ae6b35d62d7f:

  ARM: berlin: remove useless chip and system ctrl compatibles in BG2Q (2015-05-15 11:10:59 +0200)

----------------------------------------------------------------
berlin/dt for v4.2:
- GPLv2/X11 dual-license
- Consider berlin DT as unstable
- Rework of chip/system ctrl bindings
- Rework of binding documentation

----------------------------------------------------------------
Antoine Tenart (21):
      ARM: dts: berlin: relicense the berlin2q dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2Q Marvell DMP dts under GPLv2/X11
      ARM: dts: berlin: relicense the berlin2 dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2 Sony NSZ-GS7 dts under GPLv2/X11
      ARM: dts: berlin: relicense the berlin2cd dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2CD Google Chromecast dts under GPLv2/X11
      Documentation: bindings: berlin: consider our dt bindings as unstable
      Documentation: bindings: update the Berlin controllers documentation
      Documentation: bindings: move the Berlin reset documentation
      Documentation: bindings: move the Berlin pinctrl documentation
      ARM: berlin: rework chip and system controller nodes for BG2
      ARM: berlin: rework chip and system controller nodes for BG2CD
      ARM: berlin: rework chip and system controller nodes for BG2Q
      Documentation: bindings: move the Berlin clock documentation
      Documentation: bindings: update the berlin chip and system ctrl doc
      ARM: berlin: rework the clock node for BG2
      ARM: berlin: rework the clock node for BG2CD
      ARM: berlin: rework the clock node for BG2Q
      ARM: berlin: remove useless chip and system ctrl compatibles in BG2
      ARM: berlin: remove useless chip and system ctrl compatibles in BG2CD
      ARM: berlin: remove useless chip and system ctrl compatibles in BG2Q

 .../devicetree/bindings/arm/marvell,berlin.txt     | 100 +++----------
 .../devicetree/bindings/clock/marvell,berlin.txt   |  31 +++++
 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |  43 ++++++
 .../devicetree/bindings/reset/berlin,reset.txt     |  23 +++
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |  34 ++++-
 arch/arm/boot/dts/berlin2.dtsi                     | 125 +++++++++++------
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  |  34 ++++-
 arch/arm/boot/dts/berlin2cd.dtsi                   | 103 ++++++++++----
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  34 ++++-
 arch/arm/boot/dts/berlin2q.dtsi                    | 155 +++++++++++++--------
 10 files changed, 471 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt
