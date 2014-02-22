From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 01:47:48 -0500
Subject: [GIT PULL] ARM: mvebu: new SoC support for v3.15
Message-ID: <20140222064748.GZ7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a cool one.  :)  We're adding support for three new Marvell SoCs
as the chips are made available to customers.  A big thanks to Marvell
and Free-electrons for making this happen.

The new SoCs are the Armada 375, 380, and the 385.

These patches have been in -next for at least four days and the series
depends on the branch mvebu/soc up to tags/mvebu-soc-3.15.  I did this
to resolve a hidden conflict.  In mvebu/soc we deleted the map_io
handler, but when this branch renames the file to board-v7.c, it gets
added back in.  So I've resolved this internally and added the dep.

Please pull.

thx,

Jason.


The following changes since commit d181e69c91718a3c7b727596cb06ce0fb39b41d1:

  Merge tag 'tags/mvebu-soc-3.15' into mvebu/soc-3xx (2014-02-22 00:34:01 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3xx-3.15

for you to fetch changes up to bc81526f379c78607e042ec15ebbe7e04c9950d5:

  Documentation: arm: update Marvell documentation about Armada 375/38x (2014-02-22 00:44:00 +0000)

----------------------------------------------------------------
mvebu new SoCs for v3.15

 - mvebu
    - initial support for Armada 375, 380, and 385

Depends:
 - tags/mvebu-soc-3.15 (resolves delete/rename hidden conflict)

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: add initial support for the Armada 375 SOCs

Thomas Petazzoni (7):
      ARM: mvebu: rename armada-370-xp.c to board-v7.c
      ARM: mvebu: rename DT machine structure for Armada 370/XP
      ARM: mvebu: make CPU_PJ4B selection a per-SoC choice
      ARM: mvebu: add Armada 375 support to the system-controller driver
      ARM: mvebu: add workaround for data abort issue on Armada 375
      ARM: mvebu: add initial support for the Armada 380/385 SOCs
      Documentation: arm: update Marvell documentation about Armada 375/38x

 Documentation/arm/Marvell/README                   | 12 ++++-
 .../devicetree/bindings/arm/armada-375.txt         |  9 ++++
 .../devicetree/bindings/arm/armada-38x.txt         | 10 ++++
 .../bindings/arm/mvebu-system-controller.txt       |  3 +-
 arch/arm/mach-mvebu/Kconfig                        | 37 ++++++++++++--
 arch/arm/mach-mvebu/Makefile                       |  5 +-
 .../arm/mach-mvebu/{armada-370-xp.c => board-v7.c} | 58 ++++++++++++++++++++--
 arch/arm/mach-mvebu/system-controller.c            | 14 +++++-
 8 files changed, 133 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt
 rename arch/arm/mach-mvebu/{armada-370-xp.c => board-v7.c} (58%)
