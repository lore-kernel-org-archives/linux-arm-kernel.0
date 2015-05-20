From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 20 May 2015 18:50:25 +0200
Subject: [GIT PULL v2] ARM: berlin: DT changes for v4.2 (round 1)
Message-ID: <1432140626-6109-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

as pointed out by Arnd on the last PR, this is the remainder of the DT
branch based on v4.1-rc1 without the simple-mfd rework comprising

- GPLv2/X11 relicensing of all Berlin DT files with all Acked-bys.
- Unstable DT note in Berlin binding docs.
- Updated binding documentation of reworked chip/system controller and
  dependant pinctrl, clk, reset bindings.

The actual DT rework patches will be sent as a different PR based on
arm-soc driver/simple-mfd instead.

Please pull.

Thanks,
  Sebastian

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-4.2-1

for you to fetch changes up to 576efe38000dc81d8140925d9725a4f4e789514a:

  Documentation: bindings: update the berlin chip and system ctrl doc (2015-05-16 00:07:51 +0200)

----------------------------------------------------------------
Berlin DT changes for v4.2
- GPLv2/X11 dual licensing
- Mark Berlin DT bindings as unstable
- Updated binding documentation for reworked
  chip/system ctrl nodes

----------------------------------------------------------------
Antoine Tenart (12):
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
      Documentation: bindings: move the Berlin clock documentation
      Documentation: bindings: update the berlin chip and system ctrl doc

 .../devicetree/bindings/arm/marvell,berlin.txt     | 100 +++++----------------
 .../devicetree/bindings/clock/marvell,berlin.txt   |  31 +++++++
 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |  43 +++++++++
 .../devicetree/bindings/reset/berlin,reset.txt     |  23 +++++
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |  34 ++++++-
 arch/arm/boot/dts/berlin2.dtsi                     |  34 ++++++-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  |  34 ++++++-
 arch/arm/boot/dts/berlin2cd.dtsi                   |  34 ++++++-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  34 ++++++-
 arch/arm/boot/dts/berlin2q.dtsi                    |  34 ++++++-
 10 files changed, 305 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt
