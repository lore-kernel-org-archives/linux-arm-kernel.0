From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 14:38:41 +0100
Subject: [GIT PULL] at91: fixes 3.13 #2
Message-ID: <1385991521-3934-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A second round of fixes for 3.13 on top of 3.13-rc1. The main fix of this
series is the one that reduces the frequency of the i2c IP and avoid to hit
some nasty hardware bugs. It actually allows to save a little power as well...

Thanks, best regards,

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 7093bf2b7195541281cb711e31c027a8d826c6df:

  ARM: at91: fixed unresolved symbol "at91_pm_set_standby" when built without CONFIG_PM (2013-12-02 14:24:40 +0100)

----------------------------------------------------------------
AT91: second round of fixes for 3.13
- reduce IP frequency for I2C on sama5d3
- missing aliases directive for USART3 on 9x5 family
- a PM symbol is missing if !CONFIG_PM

----------------------------------------------------------------
Brent Taylor (1):
      ARM: at91: fixed unresolved symbol "at91_pm_set_standby" when built without CONFIG_PM

Ludovic Desroches (1):
      ARM: at91: sama5d3: reduce TWI internal clock frequency

Nicolas Ferre (1):
      ARM: at91: add usart3 alias to dtsi

 arch/arm/boot/dts/at91sam9x5_usart3.dtsi | 4 ++++
 arch/arm/mach-at91/pm.h                  | 4 ++++
 arch/arm/mach-at91/sama5d3.c             | 6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
