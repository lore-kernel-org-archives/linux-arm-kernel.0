From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 28 Jan 2016 10:08:35 +0100
Subject: [GIT PULL] at91: fixes for 4.5 #1
Message-ID: <1453972115-25776-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

First AT91 fixes pull-request for 4.5, all DT modifications. The bulk of the
changes is about adding the phy specification to Ethernet nodes because of
recent changes in phy drivers that tend to require a comprehensive description
of the Ethernet hardware.
It is based on 4.5-rc1 to prevent merging issues.

Thanks, best regards,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to e873cc022ce5e2c04bbc53b5874494b657e29d3f:

  ARM: dts: at91: sama5d4 xplained: fix phy0 IRQ type (2016-01-27 11:14:25 +0100)

----------------------------------------------------------------
First fixes for 4.5. Only DT changes:
- sama5d4: error in DBGU index
- addition of phy properties in several boards
- at91sam9n12ek fix a panel compatible string

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: dts: at91: at91sam9n12ek: fix panel compatible string
      ARM: dts: at91: sama5d4 xplained: properly mux phy interrupt

Mohamed Jamsheeth Hajanajubudeen (1):
      ARM: dts: at91: sama5d4: fix instance id of DBGU

Nicolas Ferre (2):
      ARM: dts: at91: sama5d2 xplained: add phy address and IRQ for macb0
      ARM: dts: at91: sama5d4 xplained: fix phy0 IRQ type

Wenyou Yang (1):
      ARM: dts: at91: sama5d4ek: add phy address and IRQ for macb0

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 12 +++++++++++-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |  8 +++++++-
 arch/arm/boot/dts/at91-sama5d4ek.dts        | 11 +++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  2 +-
 5 files changed, 31 insertions(+), 4 deletions(-)

-- 
Nicolas Ferre
