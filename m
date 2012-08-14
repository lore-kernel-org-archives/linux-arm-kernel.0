From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 14 Aug 2012 11:19:20 +0200
Subject: [PATCH v2 0/2] ARM: at91: fix drivers broken because of sparse irq
 support
Message-ID: <1344935962-18871-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hello,

The first patch fixes the rm9200 breakage (introduced by sparse irq support)
reported by Joachim Eastwood.
The second path fixes an other breakage also introduced by sparse irq support,
it concerns rtc driver.

Changes
v2:
- split in two patches
- take the opportunity of getting irq from resources for the rtc driver

Ludovic Desroches (2):
  ARM: at91: fix system timer irq issue due to sparse irq support
  ARM: at91: fix rtc-at91sam9 irq issue due to sparse irq support

 arch/arm/mach-at91/at91rm9200_time.c     |  2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9261_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9263_devices.c | 10 ++++++++--
 arch/arm/mach-at91/at91sam9g45_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9rl_devices.c  |  6 +++++-
 drivers/rtc/rtc-at91sam9.c               | 22 +++++++++++++++-------
 7 files changed, 44 insertions(+), 14 deletions(-)

-- 
1.7.11.3
