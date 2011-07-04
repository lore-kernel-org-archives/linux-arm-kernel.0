From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 23:53:22 +0200
Subject: [GIT PULL] arm soc tree, at91 patches for 3.0
Message-ID: <201107042353.22970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is the first pull request for the new arm-soc tree. These are all bug
fixes for the at91 subarchitecture that we'd still like to see merged in 3.0.

	Arnd

The following changes since commit c66a86d0cdce3bad2da794f114cc37377d242c3d:

  Merge branch 'drm-intel-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/keithp/linux-2.6 (2011-07-01 16:38:59 -0700)

are available in the git repository at:

  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-2.6-arm-soc.git/ at91/fixes

Jean-Christophe PLAGNIOL-VILLARD (3):
      at91: fix at91_set_serial_console: use platform device id
      atmel_serial: fix internal port num
      at91: fix udc, ehci and mmc clock device name for cap9/9g45/9rl

Joachim Eastwood (1):
      at91: Use "pclk" as con_id on at91cap9 and at91rm9200

Nicolas Ferre (1):
      AT91: Change nand buswidth logic to match hardware default configuration

 arch/arm/mach-at91/at91cap9.c                |    8 ++++----
 arch/arm/mach-at91/at91cap9_devices.c        |    2 +-
 arch/arm/mach-at91/at91rm9200.c              |    6 +++---
 arch/arm/mach-at91/at91rm9200_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9g45.c             |   10 +++++-----
 arch/arm/mach-at91/at91sam9g45_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9rl.c              |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c      |    2 +-
 arch/arm/mach-at91/board-cap9adk.c           |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c         |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c         |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c         |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c         |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c      |    2 +-
 arch/arm/mach-at91/include/mach/system_rev.h |   10 +++++-----
 drivers/tty/serial/atmel_serial.c            |    3 ++-
 19 files changed, 34 insertions(+), 33 deletions(-)
