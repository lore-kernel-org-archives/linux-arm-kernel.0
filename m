From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 25 Jun 2014 08:48:50 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.16
Message-ID: <20140625124850.GR10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a round of fixes for v3.16.  They' been in -next for a bit and
are based on v3.16-rc1.

The only thing that might catch your eye is the removal of the
'armada38x' compatible string.  There are no people with boards other
than the free-electrons guys, so we're safe correcting it to
'armada380' now.  Plus, the kernel it was introduced with isn't really
usable on those SoCs, there was only basic support at that time.

Please pull.

thx,

Jason.

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.16

for you to fetch changes up to 8dbdb8e704db34085f5978c335c10256b0fb9629:

  ARM: mvebu: Fix the improper use of the compatible string armada38x using a wildcard (2014-06-24 11:33:24 +0000)

----------------------------------------------------------------
mvebu fixes for v3.16

 - mvebu
    - Fix broken SoC ID detection
    - Select ARM_CPU_SUSPEND for v7
    - Remove armada38x compatible string (no users yet)

 - kirkwood
    - Fix phy-connection-type on GuruPlug board

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Fix broken SoC ID detection

Gregory CLEMENT (1):
      ARM: mvebu: Fix the improper use of the compatible string armada38x using a wildcard

Sebastian Hesselbarth (1):
      ARM: dts: kirkwood: fix phy-connection-type for Guruplug

Thomas Petazzoni (1):
      ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7 platforms

 Documentation/devicetree/bindings/arm/armada-38x.txt | 14 ++++++++++++--
 arch/arm/boot/dts/armada-380.dtsi                    |  2 +-
 arch/arm/boot/dts/armada-385-db.dts                  |  2 +-
 arch/arm/boot/dts/armada-385-rd.dts                  |  2 +-
 arch/arm/boot/dts/armada-385.dtsi                    |  2 +-
 arch/arm/boot/dts/armada-38x.dtsi                    |  2 +-
 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts  |  4 ++--
 arch/arm/mach-mvebu/Kconfig                          |  2 ++
 8 files changed, 21 insertions(+), 9 deletions(-)
