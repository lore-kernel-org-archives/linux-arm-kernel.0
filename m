From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 24 Aug 2012 17:59:47 +0200
Subject: [GIT PULL] at91: fixes for 3.6 (take 1)
Message-ID: <5037A4F3.9090608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 0d4d1e37ca732615717d4434b58682f81a6bb61c:

  ARM: at91/feature-removal-schedule: delay at91_mci removal (2012-08-24 10:45:07 +0200)

----------------------------------------------------------------
Fixes for AT91 related to:
- move to sparse IRQ: some drivers were forgotten
- a build error in sound driver & a DTS typo
- the delay for removal of old at91_mci driver

----------------------------------------------------------------
Bo Shen (1):
      ARM: at91/dts: remove partial parameter in at91sam9g25ek.dts

Joachim Eastwood (1):
      ASoC: atmel-ssc: include linux/io.h for raw io

Ludovic Desroches (3):
      ARM: at91: fix system timer irq issue due to sparse irq support
      ARM: at91: fix rtc-at91sam9 irq issue due to sparse irq support
      ARM: at91/feature-removal-schedule: delay at91_mci removal

Nicolas Ferre (1):
      ARM: at91/clock: fix PLLA overclock warning

 Documentation/feature-removal-schedule.txt |    2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts        |    2 +-
 arch/arm/mach-at91/at91rm9200_time.c       |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c   |    6 +++++-
 arch/arm/mach-at91/at91sam9261_devices.c   |    6 +++++-
 arch/arm/mach-at91/at91sam9263_devices.c   |   10 ++++++++--
 arch/arm/mach-at91/at91sam9g45_devices.c   |    6 +++++-
 arch/arm/mach-at91/at91sam9rl_devices.c    |    6 +++++-
 arch/arm/mach-at91/clock.c                 |   12 ++++++++++++
 drivers/rtc/rtc-at91sam9.c                 |   22 +++++++++++++++-------
 include/linux/atmel-ssc.h                  |    1 +
 11 files changed, 59 insertions(+), 16 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
