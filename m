From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Jun 2014 18:21:56 +0200
Subject: [GIT PULL] at91: fixes for 3.16 #1 (ter)
Message-ID: <1403713316-28253-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

An AT91 fixes batch for 3.16 that collects mainly DT fixes in relation
to the recent move to CCF on a couple of platforms.
A Kconfig symbol fix in drivers/misc is also included.

As the previous "fixes" pull-requests will be re-spin for 3.17 and shall be
ignored, I use the same tag name "at91-fixes".

Thanks, best regards,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 971dc9ce106110745f246337f229013589354536:

  ARM: at91/dt: sam9261: remove slow RC osc (2014-06-25 18:00:17 +0200)

----------------------------------------------------------------
First AT91 fixes batch for 3.16:
- drivers/misc fix for Kconfig PWM symbol
- correction of several values in DT after conversion to CCF
- fix at91sam9261/at91sam9261ek mistake in slow crystal vs. slow RC osc

----------------------------------------------------------------
Alexandre Belloni (5):
      ARM: at91/dt: sam9x5: correct PLLA ICPLL and OUT values
      ARM: at91/dt: sam9n12: correct PLLA ICPLL and OUT values
      ARM: at91/dt: sam9261: correctly define mainck
      ARM: at91/dt: define sam9261ek slow crystal frequency
      ARM: at91/dt: sam9261: remove slow RC osc

Nicolas Ferre (1):
      misc: atmel_pwm: fix Kconfig symbols

 arch/arm/boot/dts/at91sam9261.dtsi  | 21 +++++++--------------
 arch/arm/boot/dts/at91sam9261ek.dts |  4 ++++
 arch/arm/boot/dts/at91sam9n12.dtsi  |  4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi   |  4 ++--
 drivers/misc/Kconfig                |  2 +-
 5 files changed, 16 insertions(+), 19 deletions(-)

-- 
Nicolas Ferre
