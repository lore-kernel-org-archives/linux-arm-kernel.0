From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 11 Feb 2016 03:41:58 +0200
Subject: [GIT PULL] NXP LPC32xx Platform Updates for v4.6 #1
Message-ID: <56BBE6E6.4080802@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx platfrom updates (#1) for v4.6.

The main change is a switchover to a common clock framework driver
for LPC32xx, this also allows to reuse a shared LPC32xx clockevent
driver, and hence remove legacy clock and timer drivers from
arch/arm/mach-lpc32xx.

I'm adding an official LPC32xx maintainer Roland to Cc, however
he seems to be unresponsive for a quite long time (since 2014).

----------------------------------------------------------------

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/vzapolskiy/linux.git lpc32xx/soc

for you to fetch changes up to 0ac1a101f5dd28c3894be3c0230ee7ea2e05e8aa:

  arm: lpc32xx: remove direct control of GPIOs from shared mach file (2016-02-11 02:27:04 +0200)

----------------------------------------------------------------

Vladimir Zapolskiy (3):
      arm: lpc32xx: switch to common clock framework
      arm: lpc32xx: remove selected HAVE_IDE
      arm: lpc32xx: remove direct control of GPIOs from shared mach file

 arch/arm/Kconfig                |    4 +-
 arch/arm/mach-lpc32xx/Makefile  |    3 +-
 arch/arm/mach-lpc32xx/clock.c   | 1284 ---------------------------------------
 arch/arm/mach-lpc32xx/phy3250.c |   53 --
 arch/arm/mach-lpc32xx/serial.c  |    3 -
 arch/arm/mach-lpc32xx/timer.c   |  144 -----
 6 files changed, 3 insertions(+), 1488 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/clock.c
 delete mode 100644 arch/arm/mach-lpc32xx/timer.c
