From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 10:10:40 +0200
Subject: [GIT PULL] AT91 reset and ramc rework, Drivers additions
Message-ID: <20140717081040.GA30092@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Just like you asked, here is a new pull request with the patches you requested.

Thanks!
Maxime

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/at91-drivers-for-3.17

for you to fetch changes up to ae499f0fadaf28bf3138676fa2d3f6cf7d57556a:

  power: reset: Add AT91 poweroff driver (2014-07-15 13:40:34 +0200)

----------------------------------------------------------------
AT91 reset, poweroff and ram drivers

This tag holds the various new drivers introduced to move code that used to be
in mach-at91 over to the proper frameworks.

These files are the reboot and poweroff code for all AT91 SoCs but the RM9200,
and the ram controller driver is not doing much at the time, except for grabing
the RAM clock in order to leave it always enabled.

----------------------------------------------------------------
Alexandre Belloni (4):
      ARM: at91: Add new binding for sama5d3-ddramc
      memory: add a driver for atmel ram controllers
      ARM: at91: select ATMEL_SDRAMC when using OF
      clk: at91: remove the useless CLK_IGNORE_UNUSED flag

Maxime Ripard (3):
      power: reset: Add if statement instead of multiple depends on
      power: reset: Add AT91 reset driver
      power: reset: Add AT91 poweroff driver

 .../devicetree/bindings/arm/atmel-at91.txt         |   1 +
 arch/arm/mach-at91/Kconfig                         |   4 +
 arch/arm/mach-at91/setup.c                         |   1 +
 drivers/clk/at91/clk-system.c                      |   8 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/atmel-sdramc.c                      |  98 ++++++++
 drivers/power/reset/Kconfig                        |  33 ++-
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/at91-poweroff.c                | 156 +++++++++++++
 drivers/power/reset/at91-reset.c                   | 252 +++++++++++++++++++++
 11 files changed, 551 insertions(+), 15 deletions(-)
 create mode 100644 drivers/memory/atmel-sdramc.c
 create mode 100644 drivers/power/reset/at91-poweroff.c
 create mode 100644 drivers/power/reset/at91-reset.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/1a86b37e/attachment-0001.sig>
