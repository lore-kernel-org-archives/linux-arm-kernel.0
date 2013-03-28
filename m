From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 14:15:04 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.9 (round 2)
Message-ID: <20130328181504.GB13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b2d57222b0f0963258a47da0ea7f0ec451c64712:

  arm: mach-orion5x: fix typo in compatible string of a .dts file (2013-03-08 22:19:42 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.9_round2

for you to fetch changes up to 879d68a445dd7073a8c022fcdd21dc27eca7f192:

  arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port. (2013-03-28 17:29:23 +0000)

----------------------------------------------------------------
mvebu fixes for v3.9 (round 2)

 - mvebu
    - interrupt fix
    - DT pinctrl definition for sdio

 - kirkwood
    - chip-delay for GoFlex Net (fix reading nand)
    - set mvsdio unused pins to invalid value for legacy boards (0 is valid)

 - orion5x
    - fix typo in gpio parameters
    - use correct irq in dtsi

----------------------------------------------------------------
Alexander Clouter (2):
      arm: orion5x: fix orion5x.dtsi gpio parameters
      arm: orion5x: correct IRQ used in dtsi for mv_cesa

Eric Hutter (1):
      ARM: kirkwood: Fix chip-delay for GoFlex Net

Gregory CLEMENT (1):
      arm: mvebu: Use local interrupt only for the timer 0

Ryan Press (1):
      arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port.

Sebastian Hesselbarth (1):
      ARM: Kirkwood: fix unused mvsdio gpio pins

 arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
 arch/arm/boot/dts/armada-370.dtsi        | 6 ++++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts | 1 +
 arch/arm/boot/dts/orion5x.dtsi           | 9 +++++++--
 arch/arm/mach-kirkwood/guruplug-setup.c  | 2 ++
 arch/arm/mach-kirkwood/openrd-setup.c    | 1 +
 arch/arm/mach-kirkwood/rd88f6281-setup.c | 1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c  | 8 +++++---
 8 files changed, 24 insertions(+), 6 deletions(-)
