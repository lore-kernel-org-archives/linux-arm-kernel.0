From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 May 2016 16:56:19 +0200
Subject: [GIT PULL] at91: dt for 4.7 #3
Message-ID: <1462546579-3398-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Some more DT material for 4.7. The fix on the VInCo platform is due to an error
on the Ethernet driver that was not taking the gpio flag into account. As it is
about to be fixed now, I have to update the only DT that was making use of it.
Otherwise, all is about the TRNG nodes addition.

Thanks, best regards,

The following changes since commit 517550075c31917dc729d7cec0b4a0ca65294f14:

  ARM: dts: at91: sama5d2: add slow clock to watchdog node (2016-04-27 14:08:58 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt3

for you to fetch changes up to 00bf4f78b56f7d86dff5ee6242f46ef6de84f8b0:

  ARM: dts: at91: sama5d4: add trng node (2016-05-06 15:42:53 +0200)

----------------------------------------------------------------
Third batch of DT changes for 4.7:
- a fix for the VInCo platform: reset gpio specification for Ethernet
- addition of True Random Number Generator (TRNG) for all sama5 platforms
- trivial adjustment of TRNG register map size for at91sam9g45 family

----------------------------------------------------------------
Mike Williams (3):
      ARM: dts: at91: sama5d2: add trng node
      ARM: dts: at91: sama5d3: add trng node
      ARM: dts: at91: sama5d4: add trng node

Nicolas Ferre (2):
      ARM: dts: at91: VInCo: fix phy reset gpio flag
      ARM: dts: at91: at91sam9g45 family: reduce the trng register map size

 arch/arm/boot/dts/at91-vinco.dts   | 4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 7 +++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 7 +++++++
 arch/arm/boot/dts/sama5d4.dtsi     | 7 +++++++
 5 files changed, 24 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
