From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 04:27:27 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.17
Message-ID: <20140914082727.GT21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's everything we've collected so far wrt mvebu.  I don't see
anything else on the horizon atm.  These have been in -next for a while.

Please pull.

thx,

Jason.

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.17

for you to fetch changes up to ace8578182dc347b043c0825b9873f62fdaa5b77:

  ARM: mvebu: Netgear RN102: Use Hardware BCH ECC (2014-09-14 04:17:13 +0000)

----------------------------------------------------------------
mvebu fixes for v3.17

 - kirkwood
    - final driver cleanup of ARCH_KIRKWOOD removal
    - fix DT based DSA

 - mvebu
    - use BCH ECC for the RN2120 and RN104/2 nand chips

----------------------------------------------------------------
Andrew Lunn (8):
      cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
      ata: Remove ARCH_KIRKWOOD dependency
      thermal: Remove ARCH_KIRKWOOD dependency
      leds: Remove ARCH_KIRKWOOD dependency
      rtc: Remove ARCH_KIRKWOOD dependency
      watchdog: Remove ARCH_KIRKWOOD dependency
      cpufreq: Remove ARCH_KIRKWOOD dependency
      ARM: Kirkwood: Fix DT based DSA.

Arnaud Ebalard (2):
      ARM: mvebu: Netgear RN104: Use Hardware BCH ECC
      ARM: mvebu: Netgear RN2120: Use Hardware BCH ECC

klightspeed at killerwolves.net (1):
      ARM: mvebu: Netgear RN102: Use Hardware BCH ECC

 arch/arm/boot/dts/Makefile                         |  4 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  4 ++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  4 ++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  4 ++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 16 +++-----
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         | 43 ++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts        | 26 -------------
 ...-rd88f6281-a1.dts => kirkwood-rd88f6281-z0.dts} | 18 +++++----
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 27 +++-----------
 arch/arm/boot/dts/kirkwood.dtsi                    |  4 +-
 drivers/ata/Kconfig                                |  2 +-
 drivers/cpufreq/Kconfig.arm                        |  2 +-
 drivers/cpuidle/Kconfig.arm                        |  2 +-
 drivers/leds/Kconfig                               |  4 +-
 drivers/rtc/Kconfig                                |  2 +-
 drivers/thermal/Kconfig                            |  2 +-
 drivers/watchdog/Kconfig                           |  2 +-
 17 files changed, 89 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
 delete mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
 rename arch/arm/boot/dts/{kirkwood-rd88f6281-a1.dts => kirkwood-rd88f6281-z0.dts} (57%)
