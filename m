From: carlo@caione.org (Carlo Caione)
Date: Wed, 30 Mar 2016 21:35:57 +0200
Subject: [GIT PULL] ARM: Amlogic: DT fix for v4.6-rc
Message-ID: <CAOQ7t2arscn+pe4FpgzEL26rt3HtoMBP2ndSMvGQtqnDuU4pEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This is a fix for v4.6-rc since the Meson8 / Meson8b platforms are
currently broken.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/meson8-dt-fix

for you to fetch changes up to 11ca873574c2314de9f0cf1adf8b3be88e4e19ae:

  documentation: Fix pinctrl documentation for Meson8 / Meson8b
(2016-03-30 19:51:57 +0200)

----------------------------------------------------------------
With http://www.spinics.net/lists/devicetree/msg116771.html we split / refactor
the pinctrl driver to have two different pinctrl devices for each bus on the
Amlogic Meson8 / Meson8b SoCs.
These are the missing patches for documentation and DT that weren't pulled into
mainline with the driver changes.

----------------------------------------------------------------
Carlo Caione (2):
      ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b
      documentation: Fix pinctrl documentation for Meson8 / Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 +++------------
 arch/arm/boot/dts/meson8.dtsi                      | 57 ++++++++++++----------
 arch/arm/boot/dts/meson8b.dtsi                     | 12 ++++-
 3 files changed, 49 insertions(+), 58 deletions(-)
